Rails.application.routes.draw do
  mount ActivityStream::Engine => "/activity_stream"
end
