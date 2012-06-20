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
        options.reverse_merge!(Votable.default_options)

        name = assoc.to_s.singularize
        through = options[:through].to_s

        if options[:add_vote_helpers]
          self.class_eval do
            define_method :"cast_#{name}_vote" do |model, val, dir = nil|
              vote = send(:"#{name}_votes").build(value: val)

              vote.votable = model
              vote.save
            end
          end
        end

        has_many :"#{name}_votes", dependent: :destroy, as: options[:as], :class_name => options[:vote_class]
        has_many :"#{name}_#{through.pluralize}", through: :"#{name}_votes", source: through, source_type: name.classify, :uniq => true
      end
    end
  end
end
