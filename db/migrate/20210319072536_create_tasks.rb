class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :description, null: false
      t.date :due_date, null: false
      t.string :priority, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
