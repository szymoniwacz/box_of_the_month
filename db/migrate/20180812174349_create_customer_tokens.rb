class CreateCustomerTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_tokens do |t|
      t.string :token
      t.integer :customer_id

      t.timestamps
    end
  end
end
