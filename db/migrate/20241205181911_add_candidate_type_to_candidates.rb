class AddCandidateTypeToCandidates < ActiveRecord::Migration[8.0]
  def change
    add_column :candidates, :candidate_type, :string
  end
end
