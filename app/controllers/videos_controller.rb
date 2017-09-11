class VideosController < ApplicationController
  include Wisper::Publisher

  # GET /videos/1
  def show
    process_response(video_service.get(params[:id]))
  end

  # POST /videos
  def create
    response = video_service.create(video_params)
    broadcast(:upsert_video, response[:body]) if response[:status] == 201

    process_response(response)
  end

  # PATCH/PUT /videos/1
  def update
    response = video_service.update(params[:id], video_params)
    broadcast(:upsert_video, response[:body]) if response[:status] == 200

    process_response(response)
  end

  # DELETE /videos/1
  def destroy
    response = video_service.delete(params[:id])
    broadcast(:delete_video, params[:id]) if response[:status] == 204

    process_response(response)
  end

  private

  def process_response(response)
    render json: response[:body], status: response[:status]
  end

  def video_params
    params.require(:video).permit(:title, :description)
  end
end