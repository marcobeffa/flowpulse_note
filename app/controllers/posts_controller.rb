class PostsController < ApplicationController
  allow_unauthenticated_access only: [ :index, :show ]
  before_action :set_profile

  
  def index
   @posts =  @profile.contents.published.where(visibility: "pubblico").order(publication_date: :desc)
  end

  def show
    @post =  @profile.contents.published.where(visibility: "pubblico").friendly.find(params.expect(:id))
  end




  private

  def set_profile
    @profile = User.find_by(username: params[:profile_id])
  end
end
