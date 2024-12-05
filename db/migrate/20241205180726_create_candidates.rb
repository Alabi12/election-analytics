class CreateCandidates < ActiveRecord::Migration[8.0]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :party
      t.references :constituency, null: false, foreign_key: true

      t.timestamps
    end
  end
end
