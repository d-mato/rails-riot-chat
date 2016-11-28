class Channel < ApplicationRecord
  has_many :comments
  belongs_to :user

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[\w_]+\z/ }
end
