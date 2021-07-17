class AdddStatusToLicenses < ActiveRecord::Migration[6.1]
  def change
    add_column :licenses, :status, :integer
  end
end
