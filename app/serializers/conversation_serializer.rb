class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at
  has_many :users

  def attributes(*args)
    super(*args).tap do |attrs|
      attrs[:unread] = object.attributes['unread'] if object.attributes.key?('unread')
    end
  end
end
