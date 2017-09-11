class SnsPublisher
  def initialize(topic_arn, subject)
    @topic_arn = topic_arn
    @message_subject = subject
  end

  def publish(data)
    SNS_CLIENT.publish( topic_arn: @topic_arn,
                        message: data.to_json,
                        subject: @message_subject )
  end
end