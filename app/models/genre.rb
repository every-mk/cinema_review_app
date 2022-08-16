class Genre < ApplicationRecord
  # belongs_to :cinema

  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
end
