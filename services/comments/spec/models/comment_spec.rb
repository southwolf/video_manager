require 'rails_helper'

describe Comments::Comment, type: :model do
  subject { described_class.new(params) }

  let(:video_id) { SecureRandom.uuid }
  let(:commenter_id) { SecureRandom.uuid }
  let(:text) { Faker::Lovecraft.paragraph }

  shared_examples_for 'invalid comment' do
    it 'is invalid' do
      expect(subject.valid?).to eq false
    end
  end

  context 'with valid params' do
    let(:params) do
      {
          video_id: video_id,
          commenter_id: commenter_id,
          text: text
      }
    end

    before do
      subject.save!
      subject.reload
    end

    it 'has timestamps' do
      expect(subject.created_at.present?).to eq true
      expect(subject.updated_at.present?).to eq true
    end

    it 'id is a uuid' do
      expect(/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/.match(subject.id)).to_not be_nil
    end

    it 'has a text' do
      expect(subject.text).to eq params[:text]
    end

    it 'has a commenter_id' do
      expect(subject.commenter_id).to eq params[:commenter_id]
    end

    it 'has a video_id' do
      expect(subject.video_id).to eq params[:video_id]
    end
  end

  context 'with missing a video_id' do
    let(:params) do
      {
          commenter_id: commenter_id,
          text: text
      }
    end

    it_behaves_like 'invalid comment'
  end

  context 'with missing a commenter_id' do
    let(:params) do
      {
          video_id: video_id,
          text: text
      }
    end

    it_behaves_like 'invalid comment'
  end

  context 'with missing a text' do
    let(:params) do
      {
          video_id: video_id,
          commenter_id: commenter_id
      }
    end

    it_behaves_like 'invalid comment'
  end
end