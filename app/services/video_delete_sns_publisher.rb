class VideoDeleteSnsPublisher < SnsPublisher
  def initialize
    super(Rails.application.secrets.delete_video_sns_topic_arn, 'delete')
  end

  def on_delete_video(video_data)
    publish(video_data)
  end

  def publish(video_id)
    return if video_id.empty?
    super(video_id)
  end
end