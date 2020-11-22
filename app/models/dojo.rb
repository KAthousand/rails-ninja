class Dojo < ApplicationRecord
  has_many :senseis, dependent: :destroy
  has_many :students, through: :senseis
  accepts_nested_attributes_for :senseis, allow_destroy: true
end
