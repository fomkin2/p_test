class Profile < ActiveRecord::Base
  validates :name, presence: true
  validates :phone, presence: true
  belongs_to :user
end
