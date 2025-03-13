class DashboardController < ApplicationController
  before_action :filter_contents
  include Pagy::Backend

  def all
    @q = @records.ransack(params[:q])
    @pagy, @contents = pagy(@records)
  end

  def past
    @records = @records.where("publication_date > ?", params[:data])
    @q = @records.ransack(params[:q])
    @pagy, @contents = pagy(@records)
  end

  def future
    @records = @records.where("publication_date <= ?", params[:data]).order(publication_date: :desc)
    @q = @records.ransack(params[:q])
    @pagy, @contents = pagy(@records)
  end

  private

  def filter_contents
    records = Current.user.contents
    if params[:pubblicazione] != "all"
      records = records.published if params[:pubblicazione] == "pubblicato"
      records = records.scheduled if params[:pubblicazione] == "programmato"
    end
    records = records.where(visibility: params[:visibility]) if params[:visibility] != "all"
    records = records.where(stato: params[:stato]) if params[:stato] != "all"
    @records = records
  end
end
