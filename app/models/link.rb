class Link < ApplicationRecord
  include ActionView::Helpers::UrlHelper
  validates :name, uniqueness: true
  validates_presence_of :url
end
