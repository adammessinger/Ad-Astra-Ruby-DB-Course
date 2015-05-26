class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.column :customer_name, :string

      t.timestamps({:null => false})
    end
  end
end
