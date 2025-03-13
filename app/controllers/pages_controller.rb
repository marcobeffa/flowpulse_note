class PagesController < ApplicationController
  allow_unauthenticated_access

  layout "posts"
  def home
    if authenticated?
      redirect_to contents_path
    end
  end


  def utenti
  end
end
