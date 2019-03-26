class ApplicationController < ActionController::Base
  before_action :set_current_group
  before_action :set_current_user
  before_action :set_current_manager

  # 全てのアクションに対して、ユーザーがログイン済みかどうかを事前に確認
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  # 全てのアクションに対して、グループにログイン済みかどうかを事前に確認
  def set_current_group
    @current_group = Group.find_by(id: session[:group_id])
  end

  # 全てのアクションに対して、ユーザーが管理者としてログインしているかどうかを事前に確認
  def set_current_manager
    @current_manager = User.find_by(id: session[:manager_id])
  end

  # 非ログインユーザーがログイン後の画面に直接リンクした際、ログインページに強制遷移
  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to(login_form_path)
    end
  end

  # ログイン済みユーザーがログイン前の画面に直接リンクした際、部屋一覧画面に強制遷移
  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to(rooms_path)
    end
  end

  # 非管理者ユーザーが管理者専用画面に直接リンクした際、部屋一覧画面に強制遷移
  def authenticate_manager
    if @current_manager == nil
      flash[:notice] = "管理者ログインが必要です"
      redirect_to(rooms_path)
    end
  end

  # 管理者ユーザーが管理者になる前の画面に直接リンクした際、部屋一覧画面に強制遷移
  def forbid_login_manager
    if @current_manager
      flash[:notice] = "すでに管理者としてログインしています"
      redirect_to(rooms_path)
    end
  end

end
