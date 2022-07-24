class Cinema < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :screen_time, presence: true
  validates :birthplace, presence: true, length: { maximum: 20 }
  validates :movie_rating, presence: true, length: { maximum: 10 }
  validates :director, presence: true, length: { maximum: 50 }
  validates :original, presence: true, length: { maximum: 50 }
  validates :appearance, presence: true, length: { maximum: 1000 }
  validates :screenwriter, presence: true, length: { maximum: 50 }
  validates :distribution, presence: true, length: { maximum: 20 }
  validates :start_date, presence: true
  validates :story, presence: true, length: { maximum: 1000 }
end
