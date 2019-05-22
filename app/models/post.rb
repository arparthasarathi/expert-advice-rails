class Post < ApplicationRecord
  acts_as_taggable_on :tags
  acts_as_url :title, url_attribute: :slug

  belongs_to :user
  belongs_to :account
  belongs_to :question, foreign_key: 'question_id', class_name: 'Post', optional: true
  has_many :answers, foreign_key: 'question_id', class_name: 'Post'

  ## Function to override the default id param to slug
  #
  # @return [String] slug based on the post title
  def to_param
    slug
  end
end
