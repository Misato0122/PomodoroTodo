class Task < ApplicationRecord

  validates :content, presence: true, length: { maximum: 50 }

  belongs_to :user
  has_many :pomodoros, dependent: :nullify
  enum state: { todo: 0, doing: 1, done: 2 }
end
