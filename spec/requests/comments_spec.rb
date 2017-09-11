require 'rails_helper'

describe 'Comments', type: :request do
  let(:comments_service) { CommentService }
  let(:comment_id) { SecureRandom.uuid }
  let(:video_id) { SecureRandom.uuid }
  let(:commenter_id) { SecureRandom.uuid }
  let(:text) { Faker::Lovecraft.paragraph}
  let(:created_at) { Faker::Date.between(15.days.ago, 15.days.from_now).to_s }
  let(:updated_at) { Faker::Date.between(15.days.ago, 15.days.from_now).to_s }
  let(:comment_payload) do
    {
        _id: comment_id,
        video_id: video_id,
        commenter_id: commenter_id,
        text: text,
        created_at:  created_at,
        updated_at:  updated_at
    }
  end

  shared_examples_for 'not found comment' do
    it 'response has status not_found' do
      expect(response).to have_http_status(:not_found)
    end

    it 'response body has not found error message' do
      expect(json_response).to eq( { 'errors' => 'not found' } )
    end
  end

  describe 'GET /comments/:id' do
    before do
      allow_any_instance_of(comments_service).to receive(:get).and_return(service_response)
      get "#{comments_path}/#{comment_id}"
    end

    context 'when comment exists' do
      let(:expected_response) { comment_payload.stringify_keys }
      let(:service_response) { { status: 200, body: comment_payload } }

      it 'response has status ok' do
        expect(response).to be_success
      end

      it 'response has json content-type' do
        expect(response.content_type).to eq('application/json')
      end

      it 'response body contains expected comment attributes' do
        expect(json_response).to eq(expected_response)
      end
    end

    context 'when comment does not exist' do
      let(:comment_id) { 'bad_id' }
      let(:service_response) { { status: 404, body: { errors: 'not found' } } }

      it_behaves_like 'not found comment'
    end
  end

  describe 'POST /comments' do
    before do
      allow_any_instance_of(comments_service).to receive(:create).and_return(service_response)
      post comments_path, params: create_comment_params
    end

    context 'with valid parameters' do
      let(:service_response) { { status: 201, body: comment_payload } }
      let(:expected_response) do
        {
            'video_id' => video_id,
            'commenter_id' => commenter_id,
            'text' => text
        }
      end

      let(:create_comment_params) do
        {
            comment: {
                video_id: video_id,
                commenter_id: commenter_id,
                text: text
            }
        }
      end

      it 'response has status created (201)' do
        expect(response).to have_http_status(:created)
      end

      it 'response has json content-type' do
        expect(response.content_type).to eq('application/json')
      end

      it 'response body contains expected comment attributes' do
        expect(json_response).to include(expected_response)
      end
    end

    context 'with invalid parameters' do
      let(:validation_error) { { 'error' => 'some error' } }
      let(:service_response) { { status: 422, body: validation_error } }
      let(:create_comment_params) do
        {
            comment: {
                text: text
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

  describe 'PATCH /comments/:id' do
    before do
      allow_any_instance_of(comments_service).to receive(:update).and_return(service_response)
      patch "#{comments_path}/#{comment_id}", params: update_comment_params
    end

    let(:new_text) { 'new text' }
    let(:update_comment_params) do
      {
          comment: {
              text: new_text
          }
      }
    end

    context 'when comment exists' do
      let(:expected_response) do
        {
            'video_id' => video_id,
            'commenter_id' => commenter_id,
            'text' => new_text
        }
      end
      let(:comment_payload) do
        {
            video_id: video_id,
            commenter_id: commenter_id,
            text: new_text
        }
      end
      let(:service_response) { { status: 200, body: comment_payload } }

      it 'response has status ok' do
        expect(response).to be_success
      end

      it 'response has json content-type' do
        expect(response.content_type).to eq('application/json')
      end

      it 'response body contains expected comment attributes' do
        expect(json_response).to eq(expected_response)
      end
    end

    context 'when comment does not exist' do
      let(:comment_id) { 'bad_id' }
      let(:service_response) { { status: 404, body: { errors: 'not found' } } }

      it_behaves_like 'not found comment'
    end
  end

  describe 'DELETE /comment/:id' do
    before do
      allow_any_instance_of(comments_service).to receive(:delete).and_return(service_response)
      delete "#{comments_path}/#{comment_id}"
    end

    context 'when comment exists' do
      let(:service_response) { { status: 204, body: comment_payload } }

      it 'response has status no content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when comment does not exist' do
      let(:comment_id) { 'bad_id' }
      let(:service_response) { { status: 404, body: { errors: 'not found' } } }

      it_behaves_like 'not found comment'
    end
  end
end
