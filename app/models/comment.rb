class Comment < ApplicationRecord
  belongs_to :channel
  belongs_to :user, optional: true

  validates :body, presence: true
end
