class ChangeDataTypeForVotableType < ActiveRecord::Migration[5.0]
  def change
    change_column(:votes, :votable_type, :string)
  end
end
