class CreateConstituencies < ActiveRecord::Migration[8.0]
  def change
    create_table :constituencies do |t|
      t.string :name
      t.string :region

      t.timestamps
    end
  end
end
