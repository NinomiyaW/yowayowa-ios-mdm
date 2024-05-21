class Device < ApplicationRecord
  validates :device_name, presence: true, length: { maximum: 140 }
  validates :device_information, presence: true
end
