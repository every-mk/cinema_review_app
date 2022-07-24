class Celebrity < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :ruby, presence: true, length: { maximum: 20 }
  validates :date_of_birth, presence: true
  validates :birthplace, presence: true, length: { maximum: 20 }
  validates :history, presence: true, length: { maximum: 1000 }
end
