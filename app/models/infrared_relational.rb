class InfraredRelational < ActiveRecord::Base
  belongs_to :infrared
  soft_deletable dependent_associations: [:infrared]
  belongs_to :infrared_group
end
