class VideoUpsertSnsPublisher < SnsPublisher
  def initialize
    super(Rails.application.secrets.upsert_video_sns_topic_arn, 'upsert')
  end

  def on_upsert_video(video_data)
    publish(video_data)
  end

  def publish(data)
    return if data.empty?
    super(data)
  end
end