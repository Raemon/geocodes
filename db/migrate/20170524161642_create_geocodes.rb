class CreateGeocodes < ActiveRecord::Migration[5.0]
  def change
    create_table :geocodes do |t|
      t.string :address
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
