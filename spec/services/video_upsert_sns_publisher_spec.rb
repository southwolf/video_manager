require 'rails_helper'

describe VideoUpsertSnsPublisher do
  subject { described_class.new }
  let(:sns_client) { SNS_CLIENT }
  let(:upsert_subject) { 'upsert' }
  let(:sns_video_payload) do
    {
        topic_arn: Rails.application.secrets.upsert_video_sns_topic_arn,
        message: video_data.to_json,
        subject: upsert_subject
    }
  end
  let(:video_data) do
    {
        _id: SecureRandom.uuid,
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.sentence
    }
  end
  describe '.publish' do
    context 'when publishing with valid data' do
      it 'posts video upsert data to expected sns topic' do
        expect(SNS_CLIENT).to receive(:publish).with(sns_video_payload)
        subject.publish(video_data)
      end
    end

    context 'when publishing with no data' do
      let(:video_data) { {} }

      it 'does not post to sns' do
        expect(SNS_CLIENT).to_not receive(:publish)
        subject.publish(video_data)
      end
    end
  end
end