class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login
  skip_before_action :require_login, only: [:new, :create]

  private

  def require_login
    redirect_to login_path, warning: t('defaults.message.not_authenticated')
  end
end

