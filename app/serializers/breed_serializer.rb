class BreedSerializer < ActiveModel::Serializer
  attributes :name

  belongs_to	:exam