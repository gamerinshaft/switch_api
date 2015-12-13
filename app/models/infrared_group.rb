class InfraredGroup < ActiveRecord::Base
  belongs_to :user
  has_many :infrared_relationals
  has_many :infrareds, through: :infrared_relationals
  soft_deletable dependent_associations: [:user]
end
