class BookmarkController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    current_user.bookmark(@board)
  end

  def destroy
    @board = current_user.bookmarks.find(params[:board_id]).board
    current_user.unbookmark(@board)
  end
end
