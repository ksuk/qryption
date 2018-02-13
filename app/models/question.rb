class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :body, presence: true

  scope :top_5, -> { where(nil) }
end
