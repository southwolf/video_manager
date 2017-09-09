class ApplicationController < ActionController::API
  def video_service
    @video_service ||= VideoService.new
  end
end
