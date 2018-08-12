class ErrorSerializer < ActiveModel::Serializer
  attributes :status, :error, :message, :details
end
