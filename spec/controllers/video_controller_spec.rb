require 'rails_helper'

describe VideosController, type: :controller do
  let(:video_id) { SecureRandom.uuid }
  let(:title) { Faker::Lorem.sentence }
  let(:description) { Faker::Lorem.sentence }
  let(:video_service) { VideoService }
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

  describe 'POST #create' do
    before do
      allow_any_instance_of(video_service).to receive(:create).and_return(service_response)
    end

    context 'with valid params' do
      let(:service_response) { { status: 201, body: video_payload } }
      let(:create_video_params) do
        {
            video: {
                title: title,
                description: description
            }
        }
      end

      it 'broadcasts an :upsert_video event' do
        expect {
          post :create, params: create_video_params
        }.to broadcast(:upsert_video, video_payload)
      end
    end

    context 'with invalid params' do
      let(:service_response) { { status: 422, body: 'some_error' } }
      let(:invalid_create_video_params) do
        {
            video: {
                description: description
            }
        }
      end

      it 'does not broadcast an event' do
        expect {
          post :create, params: invalid_create_video_params
        }.to_not broadcast(:upsert_video)
      end
    end
  end

  describe 'PATCH #update' do
    before do
      allow_any_instance_of(video_service).to receive(:update).and_return(service_response)
    end

    let(:new_description) { 'new description' }
    let(:update_video_params) do
      {
        id: video_id,
        description: new_description
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

      it 'broadcasts an :upsert_video event' do
        expect {
          patch :update, params: { id: video_id, video: update_video_params }
        }.to broadcast(:upsert_video, hash_including(video_payload))
      end
    end

    context 'when video does not exist' do
      let(:video_id) { 'bad_id' }
      let(:service_response) { { status: 404, body: { errors: 'not found' } } }

      it 'does not broadcast an event' do
        expect {
          patch :update, params: { id: video_id, video: update_video_params }
        }.to_not broadcast(:upsert_video)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      allow_any_instance_of(video_service).to receive(:delete).and_return(service_response)
    end

    context 'when video exists' do
      let(:service_response) { { status: 204, body: video_payload } }

      it 'boradcasts a :delete_video event' do
        expect {
          delete :destroy, params: { id: video_id }
        }.to broadcast(:delete_video, video_id)
      end
    end

    context 'when video does not exist' do
      let(:video_id) { 'bad_id' }
      let(:service_response) { { status: 404, body: { errors: 'not found' } } }

      it 'does not broadcast an event' do
        expect {
          delete :destroy, params: { id: video_id }
        }.to_not broadcast(:delete_video)
      end
    end
  end
end