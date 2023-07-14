class BookmarksController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    current_user.bookmark(@board)
    flash[:success] = "ブックマークしました"
    redirect_back fallback_location: boards_path
  end

  def destroy
    @bookmark = current_user.bookmarks.find_by(board_id: params[:board_id])
    if @bookmark
      current_user.unbookmark(@bookmark.board)
      flash[:success] = "ブックマークを外しました"
    else
      flash[:error] = "ブックマークが見つかりませんでした"
    end
    redirect_back fallback_location: boards_path
  end

end
