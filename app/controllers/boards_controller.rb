class BoardsController < ApplicationController
  before_action :set_board, only: %i[edit update destroy]
  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end

  def new
    @board = Board.new
  end

  def edit; end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, success: t('defaults.message.created', item: Board.model_name.human)
    else
      flash['danger'] = t('defaults.message.not_created', item: Board.model_name.human)
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  def update
    if @board.update(board_params)
      redirect_to @board, success: t('defaults.message.updated', item: Board.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Board.model_name.human)
      render :edit
    end
  end

  def destroy
    @board.destroy!
    redirect_to boards_path, success: t('defaults.message.deleted', item: Board.model_name.human)
  end

  private

  def set_board
    @board = Board.find_by(id: params[:id])
    render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html' if @board.nil?
  end

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
