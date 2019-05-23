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

  ## Assigns the passed param to the account_id attribute of a
  #  post instance
  #
  #  @param [Integer] account_id existing account_id present in database
  #
  #  @return [nil]
  def set_account(account_id)
    self.account_id = account_id
  end
end
