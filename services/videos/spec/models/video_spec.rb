require 'rails_helper'

describe Videos::Video, type: :model do

  subject { described_class.new(params) }

  context 'with valid params' do
    let(:params) do
      {
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.sentence
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

    it 'has a title' do
      expect(subject.title).to eq params[:title]
    end

    it 'has a description' do
      expect(subject.description).to eq params[:description]
    end
  end

  context 'with missing required parameters' do
    let(:params) do
      {
          description: Faker::Lorem.sentence
      }
    end

    it 'is not valid' do
      expect(subject.valid?).to eq false
    end
  end
end
