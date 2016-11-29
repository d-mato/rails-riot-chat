class Channel < ApplicationRecord
  include Permission

  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[\w_]+\z/ }
end
