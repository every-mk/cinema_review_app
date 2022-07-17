class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  # validates :name, presence: true, length: { maximum: 30}
  # validates :sex, presence: true, numericality: { only_integer: true }
  # validates :date_of_birth, presence: true,
  # validates :prefecture, presence: true, length: { maximum: 10 }
  # validates :municipality, presence: true, length: { maximum: 10}
  # validates :image_name, presence: true, length: { maximum: 20 }
end
