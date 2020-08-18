class Rule < ApplicationRecord
  belongs_to :user

  validates :if_rule, presence: true, length: { maximum: 255 }
  validates :then_rule, presence: true, length: { maximum: 255 }



end