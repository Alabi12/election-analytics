class AddVoteCountToVotes < ActiveRecord::Migration[8.0]
  def change
    add_column :votes, :vote_count, :integer
  end
end
