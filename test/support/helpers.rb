class ActiveSupport::TestCase
  %w[ user post question group comment ].each do |type|
    class_eval <<-RUBY
      def create_#{type}(attrs = {})
        #{type.classify}.create(#{type}_attributes(attrs))
      end
    RUBY
  end

  protected

  def user_attributes(attrs)
    { name: 'Bob' }.merge! attrs
  end

  def post_attributes(attrs)
    { title: 'Sample Post' }.merge! attrs
  end

  def question_attributes(attrs)
    { body: 'Question Body' }.merge! attrs
  end

  def group_attributes(attrs)
    { name: 'Group Name' }.merge! attrs
  end

  def comment_attributes(attrs)
    { body: 'Comment Body' }.merge! attrs
  end
end
