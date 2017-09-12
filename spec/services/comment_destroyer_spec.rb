require 'rails_helper'

describe CommentsDestroyer do
  subject { described_class.new }
  let(:comments_service) { CommentService }

  describe '.destroy_comments' do
    context 'when a video is destroyed' do
      let(:video_id) { 'some_id' }

      it 'its comments are deleted' do
        expect_any_instance_of(comments_service).to receive(:delete_for_video).with(video_id)
        subject.delete_comments(video_id)
      end
    end
  end
end