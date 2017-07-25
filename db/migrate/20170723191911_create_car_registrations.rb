class CreateCarRegistrations < ActiveRecord::Migration[5.1]
  def change
    create_table :car_registrations do |t|
      t.string :contract_address, null: false
      t.jsonb :contract_abi

      t.string :coc_sha3_256
      t.binary :coc_file

      t.string :evb_sha3_256
      t.binary :evb_file

      t.string :fzb_i_sha3_256
      t.binary :fzb_i_file

      t.string :fzb_ii_sha3_256
      t.binary :fzb_ii_file

      t.references :user

      t.timestamps
    end
  end
end
