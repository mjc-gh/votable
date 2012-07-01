namespace :votable do
  namespace :rebuild do
    desc "Rebuild All Vote Totals"
    task all: :environment do
      # TODO make db agnostic
      ActiveRecord::Base.transaction do
        Vote.group(:votable_id, :voter_type, :votable_type).sum(:value).each do |fields, sum|
          attribute = :"#{fields[1].downcase}_votes_total"
          votable_klass = fields.last.constantize

          if votable_klass.attribute_method? attribute
            votable = votable_klass.find(fields.first)

            votable.update_attribute(attribute, sum)
          end
        end
      end
    end
  end
end
