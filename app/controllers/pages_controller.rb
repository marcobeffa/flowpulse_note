class PagesController < ApplicationController
  allow_unauthenticated_access


  def home
    if authenticated?
      redirect_to contents_path
    end
  end


  def utenti
  end
end
