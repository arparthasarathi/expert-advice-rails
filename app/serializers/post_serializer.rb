class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :slug, :body, :question_id
  has_many :tags
  has_many :answers
  belongs_to :question
  belongs_to :user
end
