class AddImageColumnsToVehicles < ActiveRecord::Migration
  def up
    add_attachment :vehicles, :image
  end

  def down
    remove_attachment :vehicles, :image
  end
end
