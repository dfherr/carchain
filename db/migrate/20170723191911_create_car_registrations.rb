class CreateCarRegistrations < ActiveRecord::Migration[5.1]
  def change
    create_table :car_registrations do |t|

      t.timestamps
    end
  end
end
