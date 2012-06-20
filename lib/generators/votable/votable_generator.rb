module Votable
  module Generators
    class VotableGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers

      source_root File.expand_path('../templates', __FILE__)
      desc "Generate a Vote model with the given NAME."

      namespace 'votable'
      hook_for :orm
    end
  end
end
