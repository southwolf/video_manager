class CommentsDestroyer
  def initialize
    @service = CommentService.new
  end

  def on_delete_video(video_id)
    delete_comments(video_id)
  end

  def delete_comments(video_id)
    @service.delete_for_video(video_id)
  end
end