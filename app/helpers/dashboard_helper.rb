module DashboardHelper
  def btn(type, url)
    if type.to_s == url.to_s
      "primary"
    else
      "secondary"
    end
  end
  def dashboard_path_for(type, params = {})
    routes = Rails.application.routes.url_helpers

    # Definiamo i valori predefiniti per data, stato e visibility
    default_params = {
      data: params[:data] || Date.today.strftime("%Y-%m-%d"),
      pubblicazione: params[:pubblicazione] || "all",
      visibility: params[:visibility] || "all",
      stato: params[:stato] || "all"
    }

    # Scegliamo il path corretto in base al tipo richiesto
    base_path = case type
    when :all then routes.all_path(default_params[:data], default_params[:pubblicazione], default_params[:visibility], default_params[:stato])
    when :past then routes.past_path(default_params[:data], default_params[:pubblicazione], default_params[:visibility], default_params[:stato])
    when :future then routes.future_path(default_params[:data], default_params[:pubblicazione], default_params[:visibility], default_params[:stato])
    else routes.all_path(default_params[:data], default_params[:pubblicazione], default_params[:visibility], default_params[:stato]) # Default
    end

    base_path
  end
end
