require 'rails_helper'

describe Videos::Client do

  let(:client) { described_class.new }
  let!(:video) { FactoryGirl.create(:video) }
  let(:video_id) { video.id }
  let(:video_hash) do
    video.attributes.delete('created_at')
    video.attributes.delete('updated_at')
    video.attributes
  end
  let(:valid_parameters) do
    {
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.sentence
    }
  end

  describe '.get' do
    subject { client.get(video_id) }

    context 'when video exists' do
      it 'response has 200 code' do
        expect(subject[:status]).to eq 200
      end

      it 'response body contains video attributes' do
        expect(subject[:body]).to include video_hash
      end
    end

    context 'when video does not exist' do
      let(:video_id) { 'bad_id' }

      it 'response has 404 code' do
        expect(subject[:status]).to eq 404
      end

      it 'response body contains error message' do
        expect(subject[:body]).to eq errors: 'not found'
      end
    end
  end

  describe '.create' do
    subject { client.create(create_parameters) }

    context 'with valid parameters' do
      let(:create_parameters) { valid_parameters }

      it 'creates the video' do
        expect {
          subject
        }.to change(Videos::Video, :count).by(1)
      end

      it 'response has 201 code' do
        expect(subject[:status]).to eq 201
      end

      it 'response body contains video attributes' do
        expect(subject[:body]).to include create_parameters.stringify_keys
      end
    end

    context 'with missing parameters' do
      let(:create_parameters) { { description: Faker::Lorem.sentence } }

      it 'does not create the video' do
        expect {
          subject
        }.to change(Videos::Video, :count).by(0)
      end

      it 'response has 422 status' do
        expect(subject[:status]).to eq 422
      end

      it 'response body contains validation error' do
        expect(subject[:body]).to eq(  {'title' => ["can't be blank"] } )
      end
    end
  end

  describe 'update' do
    subject { client.update(video_id, update_parameters) }

    let(:update_parameters) do
      {
          description: 'a new description'
      }
    end

    context 'when video exists' do
      it 'does not add a new video' do
        expect {
          subject
        }.to change(Videos::Video, :count).by(0)
      end

      it 'changes the video' do
        subject
        video.reload
        expect(video.description).to eq update_parameters[:description]
      end

      it 'response contains status code 200' do
        expect(subject[:status]).to eq 200
      end

      it 'response body contains video attributes' do
        body = subject[:body]
        video.reload
        expect(body).to include video.attributes.stringify_keys
      end
    end

    context 'when video does not exist' do
      let(:video_id) { 'bad_id' }

      it 'response contains status code 404' do
        expect(subject[:status]).to eq 404
      end

      it 'response body contains error message' do
        expect(subject[:body]).to eq errors: 'not found'
      end
    end
  end

  describe 'delete' do
    subject { client.delete(video_id) }

    context 'when video exists' do
      it 'response contains status code 204' do
        expect(subject[:status]).to eq 204
      end

      it 'deletes the video' do
        expect {
          subject
        }.to change(Videos::Video, :count).by(-1)
      end

      it 'response body is blank' do
        expect(subject[:body]).to eq ''
      end
    end

    context 'when video does not exist' do
      let(:video_id) { 'bad_id' }

      it 'response contains status code 404' do
        expect(subject[:status]).to eq 404
      end

      it 'response body contains error message' do
        expect(subject[:body]).to eq errors: 'not found'
      end
    end
  end
end