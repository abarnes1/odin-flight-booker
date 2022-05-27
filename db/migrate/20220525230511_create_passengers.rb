class CreatePassengers < ActiveRecord::Migration[7.0]
  def change
    create_table :passengers do |t|
      t.references :booking, foreign_key: true, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.timestamps
    end
  end
end
