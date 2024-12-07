class AddPositionToCandidates < ActiveRecord::Migration[8.0]
  def change
    add_column :candidates, :position, :string
  end
end
