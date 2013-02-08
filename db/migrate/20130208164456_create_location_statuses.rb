class CreateLocationStatuses < ActiveRecord::Migration
  def change
    create_table :location_statuses do |t|
      t.datetime :time
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
