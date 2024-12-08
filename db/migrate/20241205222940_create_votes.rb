class CreateVotes < ActiveRecord::Migration[8.0]
  def change
    create_table :votes do |t|
      t.references :candidate, null: false, foreign_key: true
      t.string :voter_name

      t.timestamps
    end
  end
end
