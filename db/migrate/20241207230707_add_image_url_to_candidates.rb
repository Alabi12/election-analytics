class AddImageUrlToCandidates < ActiveRecord::Migration[8.0]
  def change
    add_column :candidates, :image_url, :string
  end
end
