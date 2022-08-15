class Cinema < ApplicationRecord
  has_one :review, dependent: :destroy
  has_one_attached :image

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
  validates :end_date, presence: true
  validates :story, presence: true, length: { maximum: 1000 }

  validate :screening_period_validates

  def screening_period_validates
    return if self.start_date.nil? or self.end_date.nil?

    if self.start_date > self.end_date
      errors.add(:end_date, "は開始日より前の日付は無効です")
    end
  end
end
