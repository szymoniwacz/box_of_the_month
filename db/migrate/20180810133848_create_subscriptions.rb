class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.string :address
      t.string :zip_code
      t.string :plan_id
      t.timestamps
    end
  end
end
