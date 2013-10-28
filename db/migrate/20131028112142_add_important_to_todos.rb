class AddImportantToTodos < ActiveRecord::Migration
  def change
		add_column :todos, :important, :integer
    add_index :todos, :important
  end
end
