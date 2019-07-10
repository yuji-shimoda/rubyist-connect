class TopController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    if user_signed_in?
      redirect_to users_path
    end
    @users = @q.result.active.reorder(Arel.sql('RAND()')).limit(Settings.top_page_users_count)
  end
end
