class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.column :name, :string
      t.column :done, :boolean

      # the #timestamps convenience method makes a couple of default timestamp
      # columns to track when a record was created and last updated
      t.timestamps
    end
  end
end
