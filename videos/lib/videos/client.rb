module Videos
  class Client
    def get(video_id)
      response = find_video(video_id)
      if response[:found]
        { status: 200, body: response[:response][:video].attributes }
      else
        response[:response]
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
      response = find_video(video_id)
      if response[:found]
        found_video = response[:response][:video]
        found_video.update(video_params)
        found_video.reload
        { status: 200, body: found_video.attributes }
      else
        response[:response]
      end
    end

    def delete(video_id)
      response = find_video(video_id)
      if response[:found]
        response[:response][:video].delete
        { status: 204, body: ''}
      else
        response[:response]
      end
    end

    private

    def find_video(id)
      begin
        video = Video.find(id)
        { found: true, response: { video: video } }
      rescue Mongoid::Errors::DocumentNotFound
        { found: false, response: {status: 404, body: { errors: 'not found' } } }
      rescue Exception => ex
        { found: false, response: {status: 500, body: { errors: ex.message} } }
      end
    end
  end
end