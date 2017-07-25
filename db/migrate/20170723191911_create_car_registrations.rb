class CreateCarRegistrations < ActiveRecord::Migration[5.1]
  def change
    create_table :car_registrations do |t|
      t.string :contract_address, null: false
      t.jsonb :contract_abi

      t.references :user

      t.timestamps
    end
  end
end
