class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :rules
  has_many :favorites
  has_many :likes, through: :favorites, source: :rule
  
  def favorite(rule)
    self.favorites.find_or_create_by(rule_id: rule.id)
  end
   
  def unfavorite(rule)
    favorite = favorites.find_by(rule_id: rule.id)
    favorite.destroy if favorite
  end
        
  def like?(rule)
    self.likes.include?(rule)
  end
end
