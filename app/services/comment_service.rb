class CommentService
  def initialize
    @client = Comments::Client.new
  end

  def get(comment_id)
    @client.get(comment_id)
  end

  def get_for_video(video_id)
    @client.get_for_video(video_id)
  end

  def create(comment_params)
    @client.create(comment_params)
  end

  def update(comment_id, comment_params)
    @client.update(comment_id, comment_params)
  end

  def delete(comment_id)
    @client.delete(comment_id)
  end

  def delete_for_video(video_id)
    @client.delete_for_video(video_id)
  end
end