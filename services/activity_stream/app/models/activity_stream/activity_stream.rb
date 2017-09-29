module ActivityStream
  class ActivityStream
    include Mongoid::Document
    include Mongoid::Attributes::Dynamic
    include Mongoid::Timestamps

    store_in client: 'activity_stream'

    field :_id, as: :id, type: String, default: -> { SecureRandom.uuid }
    field :video_id, type: String
    field :title, type: String
    field :description, type: String
    field :comments, type: Array
  end
end