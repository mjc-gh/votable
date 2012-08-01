Votable.setup do |config|
  # set default Vote class
  config.default_vote_class = 'Vote'

  # allow Voters to recast votes (or not)
  config.allow_recast = true
end
