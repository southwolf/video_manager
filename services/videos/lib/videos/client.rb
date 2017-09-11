module Videos
  class Client
    
    def get(video_id)
      find_video(video_id) do |video|
        { status: 200, body: video.attributes }
      end
    end

    def create(video_params)
      video = Video.new(video_params)
      if video.save
        { status: 201, body: video.attributes }
      else
        { status: 422, body: video.errors.messages.stringify_keys }
      end
    end

    def update(video_id, video_params)
      find_video(video_id) do |video|
        video.update(video_params)
        video.reload
        { status: 200, body: video.attributes }
      end
    end

    def delete(video_id)
      find_video(video_id) do |video|
        video.delete
        { status: 204, body: ''}
      end
    end

    private

    def find_video(id)
      begin
        yield Video.find(id)
      rescue Mongoid::Errors::DocumentNotFound
        { status: 404, body: { errors: 'not found' } }
      rescue Exception => ex
        { status: 500, body: { errors: ex.message} }
      end
    end
  end
end