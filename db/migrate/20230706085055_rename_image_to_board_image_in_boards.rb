class RenameImageToBoardImageInBoards < ActiveRecord::Migration[5.2]
  def change
    rename_column :boards, :image, :board_image
  end
end
