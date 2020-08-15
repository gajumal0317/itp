class Rule < ApplicationRecord
  belongs_to :user

  validates :if_rule, presence: true, length: { maximum: 255 }
  validates :then_rule, presence: true, length: { maximum: 255 }


  def self.sort(selection = 'new')
    case selection
    when 'new'      
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    when 'likes'
      return find(Favorite.group(:rule_id).order(Arel.sql('count(rule_id) desc')).pluck(:rule_id))
    when 'dislikes'
      return find(Favorite.group(:rule_id).order(Arel.sql('count(rule_id) asc')).pluck(:rule_id))
    end
  end
end