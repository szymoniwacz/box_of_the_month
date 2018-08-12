class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :token
      t.boolean :success
      t.integer :error_code
      t.integer :subscription_id
      t.float :amount
      t.timestamps
    end
  end
end
