class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :flight, foreign_key: true, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :confirmation_code, null: false
      t.timestamps
    end

    add_index(:bookings, :confirmation_code)
  end
end
