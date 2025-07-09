class Api::V1::Profiles::PostsController < ApplicationController
        allow_unauthenticated_access
        before_action :set_profile

        # Lista di tutti i post pubblici (solo note)
        def index
          @posts =  @profile.contents.published.where(visibility: "pubblico").order(publication_date: :asc)
          render json: @posts
        end

        # Singolo post (controlla che sia pubblico e sia una nota)
        def show
          @post =  @profile.contents.published.where(visibility: "pubblico").friendly.find(params.expect(:id))
          if @post
            render json: @post
          else
            render json: { error: "Post not found or not public" }, status: :not_found
          end
        end

        private

        def set_profile
          @profile = User.find_by(username: params[:profile_id])
          render json: { error: "Profile not found" }, status: :not_found unless @profile
        end
end
