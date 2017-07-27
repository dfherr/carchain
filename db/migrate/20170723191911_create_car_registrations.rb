class CreateCarRegistrations < ActiveRecord::Migration[5.1]
  def change
    create_table :car_registrations do |t|
      t.string :contract_address, null: false
      t.jsonb :contract_abi, null: false

      t.string :identity_card_sha3_256
      t.string :identity_card_file_name
      t.binary :identity_card_file

      t.string :coc_sha3_256
      t.string :coc_file_name
      t.binary :coc_file

      t.string :certificate_registration_sha3_256
      t.string :certificate_registration_file_name
      t.binary :certificate_registration_file

      t.string :certificate_title_sha3_256
      t.string :certificate_title_file_name
      t.binary :certificate_title_file

      t.string :hu_sha3_256
      t.string :hu_file_name
      t.binary :hu_file


      t.references :user

      t.timestamps
    end

    add_index :car_registrations, :contract_address, unique: true
  end
end
