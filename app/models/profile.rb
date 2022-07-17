class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  enum sex: { man: 0, woman: 1 }

  validates :name, presence: true, length: { maximum: 30}
  validates :sex, presence: true, inclusion: { in: Profile.sexes.keys }
  validates :date_of_birth, presence: true
  validates :prefecture, presence: true, length: { maximum: 10 }
  validates :municipality, presence: true, length: { maximum: 10}
end
