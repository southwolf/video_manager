class ApplicationController < ActionController::API
  def video_service
    @video_service ||= VideoService.new
  end

  def comment_service
    @video_service ||= CommentService.new
  end

  private

  def process_response(response)
    render json: response[:body], status: response[:status]
  end
end
