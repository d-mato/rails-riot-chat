class Comment < ApplicationRecord
  belongs_to :channel

  validates :body, presence: true
end
