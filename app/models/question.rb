class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  scope :top_5, -> { where(nil) }
end
