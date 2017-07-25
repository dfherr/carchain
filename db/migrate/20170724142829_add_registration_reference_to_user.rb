class AddRegistrationReferenceToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :car_registration, foreign_key: true
  end
end
