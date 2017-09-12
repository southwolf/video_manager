class CommentsController < ApplicationController

  # GET /comments/1
  def show
    process_response(comment_service.get(params[:id]))
  end

  # get /comments?video_id=1
  def show_for_video
    process_response(comment_service.get_for_video(params[:video_id]))
  end

  # POST /videos
  def create
    process_response(comment_service.create(comment_params))
  end

  # PATCH/PUT /comments/1
  def update
    process_response(comment_service.update(params[:id], comment_params))
  end

  # DELETE /comments/1
  def destroy
    process_response(comment_service.delete(params[:id]))
  end

  private

  def comment_params
    params.require(:comment).permit(:video_id,
                                    :commenter_id,
                                    :text)
  end
end