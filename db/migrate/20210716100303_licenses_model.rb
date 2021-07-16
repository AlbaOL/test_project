class LicensesModel < ActiveRecord::Migration[6.1]
  def change
    create_table :licenses do |t|
      t.string :rider_id, null: false
      t.string :rider_name, null: false
      t.string :ba_email, null: false
      t.string :rider_license_id, null: false
      t.string :sex, null: false
      t.datetime :rider_birth_date, null: false
      t.datetime :expiration_date, null: false
      t.string :license_routes, array: true, default: []

      t.timestamps
    end
  end
end
