require 'rails_helper'

describe VideoDeleteSnsPublisher do
  subject { described_class.new }
  let(:sns_client) { SNS_CLIENT }
  let(:upsert_subject) { 'delete' }
  let(:sns_video_payload) do
    {
        topic_arn: Rails.application.secrets.delete_video_sns_topic_arn,
        message: video_id.to_json,
        subject: upsert_subject
    }
  end

  describe '.publish' do
    context 'when publishing with valid video id' do
      let(:video_id) { SecureRandom.uuid }

      it 'posts video upsert data to expected sns topic' do
        expect(SNS_CLIENT).to receive(:publish).with(sns_video_payload)
        subject.publish(video_id)
      end
    end

    context 'when publishing with no video id' do
      let(:video_data) { '' }

      it 'does not post to sns' do
        expect(SNS_CLIENT).to_not receive(:publish)
        subject.publish(video_data)
      end
    end
  end
end