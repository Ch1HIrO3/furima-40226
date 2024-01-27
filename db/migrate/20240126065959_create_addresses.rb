class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string     :zip_code         , null: false
      t.integer    :state_province_id, null: false
      t.string     :city_town_village, null: false
      t.string     :street_address   , null: false
      t.string     :building_name
      t.string     :telephone        , null: false                   
      t.references :order            , null: false, foreign_key: true
      t.timestamps
    end
  end
end