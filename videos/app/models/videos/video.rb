module Videos
  class Video
    include Mongoid::Document
    include Mongoid::Attributes::Dynamic
    include Mongoid::Timestamps

    store_in client: 'videos'

    field :_id, as: :id, type: String, default: -> { SecureRandom.uuid }
    field :title, type: String
    field :description, type: String

    validates_presence_of :title
  end
end