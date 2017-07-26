class CreateInsuranceContracts < ActiveRecord::Migration[5.1]
  def change
    create_table :insurance_contracts do |t|
      t.string :contract_address, null: false
      t.jsonb :contract_abi, null: false

      t.timestamps
    end
  end
end
