module Votable
  module Model
    ##
    # This method is called from a model class that can be voted on
    def votable_by(*args)
      options = args.extract_options!
      options.reverse_merge!(through: :voter, as: :votable)

      create_votable_associations(args, options)
    end

    ##
    # This method is called from a model class that casts votes, such
    # as a User or Group type model.
    def votes_on(*args)
      options = args.extract_options!
      options.reverse_merge!(through: :votable, as: :voter, add_vote_helpers: true)

      create_votable_associations(args, options)
    end

    private

    def create_votable_associations(associations, options)
      associations.each do |assoc|
        options.reverse_merge!({
          vote_class: Votable.default_vote_class, allow_recast: Votable.allow_recast
        })

        name = assoc.to_s.downcase.singularize
        through = options[:through].to_s

        klass = options[:votable_class] ? options[:votable_class] : name.classify
        scoped = klass.downcase != name

        vote_conditions = { "#{through}_type" => klass }
        vote_conditions[:scope] = name if scoped

        if options[:add_vote_helpers]
          self.class_eval do
            ##
            # Dynamically add a cast_NAME_vote method to the Voter. This method
            # will return true\false for whether or not the Vote was created.
            # If allow_recast is enabled the Voter's initial Vote will updated
            # to the new value
            #
            define_method :"cast_#{name}_vote" do |votable, val|
              #query = { votable_id: votable }
              #query[:scope] = name if scoped
              query = vote_conditions.merge({ votable_id: votable })
              vote = send("#{name}_votes").where(query).first

              if vote
                # need to return boolean regardless if recast is allowed
                options[:allow_recast] ? vote.update_attributes(value: val) : false

              else
                vote = send(:"#{name}_votes").build(value: val)

                vote.votable_type = votable.class.model_name unless vote.votable_type
                vote.votable_id = votable.id

                vote.save
              end
            end
          end
        end

        # setup join relation
        has_many :"#{name}_votes", as: options[:as], class_name: options[:vote_class], conditions: vote_conditions do
          def voted_on?(obj, direction = nil)
            extra = case direction
            when :up, :positive then "value > 0"
            when :down, :negative then "value < 0"
            end

            query = where(votable_id: obj.respond_to?(:id) ? obj.id : obj)
            query = where(extra) if extra

            query.limit(1).any?
          end
        end

        # setup through relationship
        has_many :"#{name}_#{through.pluralize}", through: :"#{name}_votes", source: through, source_type: klass, uniq: true
      end
    end
  end
end
