require 'rails_helper'

describe ActivityStream::ActivityStream, type: :model do
  subject { described_class.new(params) }

  context 'with valid params' do
    let(:params) do
      {
        video: {
            video_id: SecureRandom.uuid,
            title: Faker::Lorem.sentence,
            description: Faker::Lorem.sentence
        },
        comments: [

        ]

      }
    end

    before do
      subject.save!
    end

    it 'has timestamps' do
      expect(subject.created_at.present?).to eq true
      expect(subject.updated_at.present?).to eq true
    end


  end

  context 'with missing required params' do
    let(:params) do
      {

      }
    end

    xit 'is not valid' do
      expect(subject.valid?).to eq false
    end
  end
end