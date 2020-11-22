class Sensei < ApplicationRecord
  belongs_to :dojo
  has_many :students, dependent: :destroy
  accepts_nested_attributes_for :students, allow_destroy: true
end
