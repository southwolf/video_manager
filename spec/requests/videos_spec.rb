require 'rails_helper'

describe 'Videos', type: :request do
  let(:video_service) { VideoService }
  let(:video_id) { SecureRandom.uuid }
  let(:title) { Faker::Lorem.sentence }
  let(:description) { Faker::Lorem.sentence }
  let(:created_at) { Faker::Date.between(15.days.ago, 15.days.from_now).to_s }
  let(:updated_at) { Faker::Date.between(15.days.ago, 15.days.from_now).to_s }
  let(:video_payload) do
    {
        _id: video_id,
        title: title,
        description: description,
        created_at:  created_at,
        updated_at:  updated_at
    }
  end

  shared_examples_for 'not found video' do
    it 'response has status not_found' do
      expect(response).to have_http_status(:not_found)
    end

    it 'response body has not found error message' do
      expect(json_response).to eq( { 'errors' => 'not found' } )
    end
  end

  describe 'GET /videos/:id' do
    before do
      allow_any_instance_of(video_service).to receive(:get).and_return(service_response)
      get "#{videos_path}/#{video_id}"
    end

    context 'when video exists' do
      let(:expected_response) { video_payload.stringify_keys }
      let(:service_response) { { status: 200, body: video_payload } }

      it 'response has status ok' do
        expect(response).to be_success
      end

      it 'response has json content-type' do
        expect(response.content_type).to eq('application/json')
      end

      it 'response body contains expected video attributes' do
        expect(json_response).to eq(expected_response)
      end
    end

    context 'when video does not exist' do
      let(:video_id) { 'bad_id' }
      let(:service_response) { { status: 404, body: { errors: 'not found' } } }

      it_behaves_like 'not found video'
    end
  end

  describe 'POST /videos' do
    before do
      allow_any_instance_of(video_service).to receive(:create).and_return(service_response)
      post videos_path, params: create_video_params
    end

    context 'with valid parameters' do
      let(:service_response) { { status: 201, body: video_payload } }
      let(:expected_response) do
        {
            'title' => title,
            'description' => description
        }
      end

      let(:create_video_params) do
        {
            video: {
                title: title,
                description: description
            }
        }
      end

      it 'response has status created (201)' do
        expect(response).to have_http_status(:created)
      end

      it 'response has json content-type' do
        expect(response.content_type).to eq('application/json')
      end

      it 'response body contains expected video attributes' do
        expect(json_response).to include(expected_response)
      end
    end

    context 'with invalid parameters' do
      let(:validation_error) { { 'error' => 'some error' } }
      let(:service_response) { { status: 422, body: validation_error } }
      let(:create_video_params) do
        {
            video: {
                description: description
            }
        }
      end
      it 'response has status unprocessable entity (422)' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'response body has validation error message' do
        expect(json_response).to eq(validation_error)
      end
    end
  end

  describe 'PATCH /videos/:id' do
    before do
      allow_any_instance_of(video_service).to receive(:update).and_return(service_response)
      patch "#{videos_path}/#{video_id}", params: update_video_params
    end

    let(:new_description) { 'new description' }
    let(:update_video_params) do
      {
          video: {
              description: new_description
          }
      }
    end

    context 'when video exists' do
      let(:expected_response) do
        {
            'title' => title,
            'description' => new_description
        }
      end
      let(:video_payload) do
        {
            title: title,
            description: new_description
        }
      end
      let(:service_response) { { status: 200, body: video_payload } }

      it 'response has status ok' do
        expect(response).to be_success
      end

      it 'response has json content-type' do
        expect(response.content_type).to eq('application/json')
      end

      it 'response body contains expected video attributes' do
        expect(json_response).to eq(expected_response)
      end
    end

    context 'when video does not exist' do
      let(:video_id) { 'bad_id' }
      let(:service_response) { { status: 404, body: { errors: 'not found' } } }

      it_behaves_like 'not found video'
    end
  end

  describe 'DELETE /videos/:id' do
    before do
      allow_any_instance_of(video_service).to receive(:delete).and_return(service_response)
      delete "#{videos_path}/#{video_id}"
    end

    context 'when video exists' do
      let(:service_response) { { status: 204, body: video_payload } }

      it 'response has status no content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when video does not exist' do
      let(:video_id) { 'bad_id' }
      let(:service_response) { { status: 404, body: { errors: 'not found' } } }

      it_behaves_like 'not found video'
    end
  end
end
