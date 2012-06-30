module Votable
  module Generators
    class VotableGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers

      desc "Generate a Vote model with the given NAME."

      namespace 'votable'
      hook_for :orm
    end
  end
end
