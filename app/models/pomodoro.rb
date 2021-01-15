class Pomodoro < ApplicationRecord
  belongs_to :user
  belongs_to :task

  scope :pomodoro_today, -> { where(created_at: Time.zone.now.all_day )}
end
