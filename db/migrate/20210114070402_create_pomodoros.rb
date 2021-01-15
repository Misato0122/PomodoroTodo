class CreatePomodoros < ActiveRecord::Migration[6.0]
  def change
    create_table :pomodoros do |t|
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
