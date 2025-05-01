class ContentsController < ApplicationController
  include Pagy::Backend

  before_action :set_content, only: %i[ edit update destroy show]

  # GET /contents or /contents.json
  def index
    records = Current.user.contents
    @q = records.ransack(params[:q]) # ⚡️ Assicurati di passare sempre un oggetto ransack

    @pagy, @contents = if params[:q].present?
                        pagy(@q.result(distinct: true))
    else
                        pagy(records)
    end
    # if params[:title_i_cont].present?
    #   @q = records.ransack(params[:title_i_cont])
    #   @pagy, @contents = pagy(@q.result(distinct: true))
    # else
    #   @contents = records
    #   @pagy, @content = pagy(@contents)
    # end
    @stato = params[:stato].presence  # diventa nil se è una stringa vuota
    @publication_date = params[:publication_date].presence  # diventa nil se è una stringa vuota
    @visibility = params[:visibility].presence  # diventa nil se è una stringa vuota
  end

  # GET /contents/1 or /contents/1.json
  def show
  end

  # GET /contents/new
  def new
    @content = Current.user.contents.build
  end

  # GET /contents/1/edit
  def edit
  end

  # POST /contents or /contents.json
  def create
    @content = Current.user.contents.build(content_params)

    respond_to do |format|
      if @content.save
        format.html { redirect_to @content, notice: "Content was successfully created." }
        format.json { render :show, status: :created, location: @content }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contents/1 or /contents/1.json
  def update
    respond_to do |format|
      if @content.update(content_params)
        format.html { redirect_to @content, notice: "Content was successfully updated." }
        format.json { render :show, status: :ok, location: @content }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1 or /contents/1.json
  def destroy
    @content.destroy!

    respond_to do |format|
      format.html { redirect_to contents_path, status: :see_other, notice: "Content was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Current.user.contents.friendly.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def content_params
      params.expect(content: [ :user_id, :title, :description, :body, :publication_date, :visibility, :published, :stato, :slug, :image, :video_url ])
    end
end
