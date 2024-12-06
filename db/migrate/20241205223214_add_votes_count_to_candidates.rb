class AddVotesCountToCandidates < ActiveRecord::Migration[8.0]
  def change
    add_column :candidates, :votes_count, :integer, default: 0, null: false
  end
end
