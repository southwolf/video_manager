class VideoService
  def initialize
    @client = Videos::Client.new
  end

  def get(video_id)
    @client.get(video_id)
  end

  def create(video_params)
    @client.create(video_params)
  end

  def update(video_id, video_params)
    @client.update(video_id, video_params)
  end

  def delete(video_id)
    @client.delete(video_id)
  end
end