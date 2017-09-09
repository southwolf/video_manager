class VideosController < ApplicationController

  # GET /videos/1
  def show
    process_response(video_service.get(params[:id]))
  end

  # POST /videos
  def create
    process_response(video_service.create(video_params))
  end

  # PATCH/PUT /videos/1
  def update
    process_response(video_service.update(params[:id], video_params))
  end

  # DELETE /videos/1
  def destroy
    process_response(video_service.delete(params[:id]))
  end

  private

  def process_response(response)
    render json: response[:body], status: response[:status]
  end

  def video_params
    params.require(:video).permit(:title, :description)
  end
end