class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.string :desc
      t.date :dued
      t.boolean :done

      t.timestamps
    end
  end
end
