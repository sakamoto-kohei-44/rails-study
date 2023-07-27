class Admin::UserSessionsController < Admin::BaseController     # #BaseControllerを継承する
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :check_admin, only: %i[new create destroy]
  layout 'admin_login'        # ログインページ用のレイアウトを用意するので宣言

  def new; end

  def create
    @user = login(params[:email], params[:password]) # Sorceryメソッド  emailとpasswordでログイン認証する
    if @user
      redirect_to admin_root_path, success: t('admin.user_sessions.create.success')
    else
      flash.now[:danger] = t('fail')
      render :new
    end
  end

  def destroy
    logout# ログアウトするためのSorceryメソッド
    redirect_to admin_login_path, success: t('admin.user_sessions.destroy.success')
  end
end
