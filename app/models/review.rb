class Review < ApplicationRecord
  belongs_to :user
  belongs_to :cinema

  enum after_watch: { want_to_see_again: 0, want_to_see_when_forget: 1, do_not_want_to_see: 2 }

  validates :recommendation, inclusion: { in: [true, false] }
  validates :after_watch, presence: true, inclusion: { in: Review.after_watches.keys }
  validates :spoiler, inclusion: { in: [true, false] }
  validates :content, presence: true, length: { maximum: 500 }
end
