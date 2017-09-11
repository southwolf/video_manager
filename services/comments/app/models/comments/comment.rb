module Comments
  class Comment
    include Mongoid::Document
    include Mongoid::Attributes::Dynamic
    include Mongoid::Timestamps

    store_in client: 'comments'

    field :_id, as: :id, type: String, default: -> { SecureRandom.uuid }
    field :video_id, type: String
    field :commenter_id, type: String
    field :text, type: String

    validates_presence_of :video_id, :commenter_id, :text
  end
end