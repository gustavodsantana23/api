class NewsSerializer < ActiveModel::Serializer
  attributes :title, :text, :picture, :link
end


