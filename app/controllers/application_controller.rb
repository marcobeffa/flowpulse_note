class ApplicationController < ActionController::Base
  include Authentication

  allow_browser versions: :modern

  rescue_from ActionView::MissingTemplate, with: :fallback_for_old_browser
  rescue_from ActionController::UnknownFormat, with: :fallback_for_old_browser
  
  private

  def fallback_for_old_browser(exception)
    if request.variant == :simple || exception.message.include?("Not Acceptable")
      # fallback per browser non supportati
      render template: "fallback/unsupported_browser", layout: "simpleposts", status: 406
    else
      raise exception # re-lancia se non � legato al browser
    end
  end
end