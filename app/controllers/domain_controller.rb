class DomainController < ApplicationController
  allow_unauthenticated_access
  
  layout "posts"
  def markpostura
    @profile = User.find_by(username: "markpostura")
    if @profile.nil? 
      @profile = User.all.first 
    end
    
    @posts =  @profile.contents.published.where(visibility: "pubblico").order(publication_date: :desc)
    render "posts/index"
  end
end
