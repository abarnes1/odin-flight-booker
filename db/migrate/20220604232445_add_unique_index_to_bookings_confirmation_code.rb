class AddUniqueIndexToBookingsConfirmationCode < ActiveRecord::Migration[7.0]
  def change
    remove_index :bookings, :confirmation_code
    add_index :bookings, :confirmation_code, unique: true
  end
end
