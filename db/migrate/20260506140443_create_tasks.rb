class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.string :status, null: false
      t.integer :story_points, null: false
      t.references :sprint, null: false, foreign_key: true

      t.timestamps
    end
  end
end
