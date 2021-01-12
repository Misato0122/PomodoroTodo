class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :content, null: false
      t.integer :state, null: false, default: 0
      t.date :deadline

      t.timestamps
    end
  end
end
