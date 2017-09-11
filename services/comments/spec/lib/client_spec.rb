require 'rails_helper'

describe Comments::Client do
  let(:client) { described_class.new }
  let!(:comment) { FactoryGirl.create(:comment) }
  let(:comment_id) { comment.id }
  let(:comment_hash) do
    comment.attributes.delete('created_at')
    comment.attributes.delete('updated_at')
    comment.attributes
  end
  let(:valid_parameters) do
    {
        video_id: SecureRandom.uuid,
        commenter_id: SecureRandom.uuid,
        text: Faker::Lovecraft.paragraph
    }
  end

  describe '.get' do
    subject { client.get(comment_id) }

    context 'when comment exists' do
      it 'response has 200 code' do
        expect(subject[:status]).to eq 200
      end

      it 'response body contains comment attributes' do
        expect(subject[:body]).to include comment_hash
      end
    end

    context 'when comment does not exist' do
      let(:comment_id) { 'bad_id' }

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

      it 'creates the comment' do
        expect{
          subject
        }.to change(Comments::Comment, :count).by(1)
      end

      it 'response has 201 code' do
        expect(subject[:status]).to eq 201
      end

      it 'response body contains video attributes' do
        expect(subject[:body]).to include create_parameters.stringify_keys
      end
    end

    context 'with missing parameters' do
      let(:create_parameters) do
        valid_parameters.delete(:video_id)
        valid_parameters
      end

      it 'does not create the comment' do
        expect {
          subject
        }.to change(Comments::Comment, :count).by(0)
      end

      it 'response has 422 status' do
        expect(subject[:status]).to eq 422
      end

      it 'response body contains validation error' do
        expect(subject[:body]).to eq(  {'video_id' => ["can't be blank"] } )
      end
    end
  end

  describe '.update' do
    subject { client.update(comment_id, update_parameters) }

    let(:update_parameters) do
      {
          text: 'a new text'
      }
    end

    context 'when comment exists' do
      it 'does not add a new comment' do
        expect {
          subject
        }.to change(Comments::Comment, :count).by(0)
      end

      it 'changes the comment' do
        subject
        comment.reload
        expect(comment.text).to eq update_parameters[:text]
      end

      it 'response contains status code 200' do
        expect(subject[:status]).to eq 200
      end

      it 'response body contains comment attributes' do
        body = subject[:body]
        comment.reload
        expect(body).to include comment.attributes.stringify_keys
      end
    end

    context 'when comment does not exist' do
      let(:comment_id) { 'bad_id' }

      it 'response contains status code 404' do
        expect(subject[:status]).to eq 404
      end

      it 'response body contains error message' do
        expect(subject[:body]).to eq errors: 'not found'
      end
    end
  end

  describe '.delete' do
    subject { client.delete(comment_id) }

    context 'when comment exists' do
      it 'response contains status code 204' do
        expect(subject[:status]).to eq 204
      end

      it 'deletes the comment' do
        expect {
          subject
        }.to change(Comments::Comment, :count).by(-1)
      end

      it 'response body is blank' do
        expect(subject[:body]).to eq ''
      end
    end

    context 'when comment does not exist' do
      let(:comment_id) { 'bad_id' }

      it 'response contains status code 404' do
        expect(subject[:status]).to eq 404
      end

      it 'response body contains error message' do
        expect(subject[:body]).to eq errors: 'not found'
      end
    end
  end
end