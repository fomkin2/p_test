class Page < ActiveRecord::Base
  belongs_to :menu

  validates :uid, uniqueness: true
end
