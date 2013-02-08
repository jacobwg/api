class AddAccuracyToLocationStatus < ActiveRecord::Migration
  def change
    add_column :location_statuses, :accuracy, :float
  end
end
