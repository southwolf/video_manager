module Comments
  class Client

    def get(comment_id)
      find_comment(comment_id) do |comment|
        { status: 200, body: comment.attributes }
      end
    end

    def create(comment_params)
      comment = Comment.new(comment_params)
      if comment.save
        { status: 201, body: comment.attributes }
      else
        { status: 422, body: comment.errors.messages.stringify_keys }
      end
    end

    def update(comment_id, comment_params)
      find_comment(comment_id) do |comment|
        comment.update(comment_params)
        comment.reload
        { status:200, body: comment.attributes }
      end
    end

    def delete(comment_id)
      find_comment(comment_id) do |comment|
        comment.delete
        { status: 204, body: '' }
      end
    end

    private

    def find_comment(id)
      begin
        yield Comment.find(id)
      rescue Mongoid::Errors::DocumentNotFound
        { status: 404, body: { errors: 'not found' } }
      rescue Exception => ex
        { status: 500, body: { errors: ex.message } }
      end
    end
  end
end