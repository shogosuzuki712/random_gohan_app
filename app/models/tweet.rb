class Tweet < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :title, length: { maximum: 30 }
    validates :text, length: { maximum: 140 }
  end
end
