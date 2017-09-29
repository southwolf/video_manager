require 'rails_helper'

describe ActivityStream::ActivityStream, type: :model do
  subject { described_class.new(params) }

  let(:video_id) { SecureRandom.uuid }
  let(:title) { Faker::Lorem.sentence }
  let(:description) { Faker::Lorem.sentence }
  let(:comment_1) do
    {
      comment_id: SecureRandom.uuid,
      commenter_id: SecureRandom.uuid,
      text: Faker::Lovecraft.paragraph
    }
  end
  let(:comment_2) do
    {
        comment_id: SecureRandom.uuid,
        commenter_id: SecureRandom.uuid,
        text: Faker::Lovecraft.paragraph
    }
  end
  let(:comment_3) do
    {
        comment_id: SecureRandom.uuid,
        commenter_id: SecureRandom.uuid,
        text: Faker::Lovecraft.paragraph
    }
  end

  context 'with valid params' do
    let(:params) do
      {
        video_id: video_id,
        title: title,
        description: description,
        comments: [
          comment_1,
          comment_2,
          comment_3
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

    it 'id is a uuid' do
      expect(/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/.match(subject.id)).to_not be_nil
    end

    it 'has video attribs' do
      expect(subject.video_id).to eq video_id
      expect(subject.title).to eq title
      expect(subject.description).to eq description
    end

    it 'has comments' do
      expect(subject.comments).to include comment_1
      expect(subject.comments).to include comment_2
      expect(subject.comments).to include comment_3
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