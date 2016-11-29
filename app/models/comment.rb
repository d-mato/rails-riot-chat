class Comment < ApplicationRecord
  include Permission

  belongs_to :channel
  belongs_to :user, optional: true

  validates :body, presence: true
end
