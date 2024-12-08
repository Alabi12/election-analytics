class RemoveVoterNameFromVotes < ActiveRecord::Migration[8.0]
  def change
    remove_column :votes, :voter_name, :string
  end
end
