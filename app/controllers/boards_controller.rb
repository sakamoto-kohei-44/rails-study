class BoardsController < ApplicationController
  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, notice: t('flash.notices.board_created')
    else
      flash.now[:alert] = t('flash_message.bordcreation_filed')
      render :new
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :body)
  end
end
