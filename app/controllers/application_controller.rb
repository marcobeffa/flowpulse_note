class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  rescue_from ActionView::MissingTemplate, with: :fallback_for_old_browser

  private

  def fallback_for_old_browser
    render template: "fallback/unsupported_browser", layout: "simpleposts", status: :not_acceptable
  end
end