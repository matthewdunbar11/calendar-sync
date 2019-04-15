class EventSerializer < ActiveModel::Serializer
  attributes :id, :start, :end, :title, :url

  def url
    view_context.event_url(object)
  end
end
