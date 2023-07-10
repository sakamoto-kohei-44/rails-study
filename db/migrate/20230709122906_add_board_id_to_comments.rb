class AddBoardIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :board_id, :integer
  end
end
