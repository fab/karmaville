class User < ActiveRecord::Base
  has_many :karma_points

  attr_accessible :first_name, :last_name, :email, :username, :total_karma

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  validates :username,
            :presence => true,
            :length => {:minimum => 2, :maximum => 32},
            :format => {:with => /^\w+$/},
            :uniqueness => {:case_sensitive => false}

  validates :email,
            :presence => true,
            :format => {:with => /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i},
            :uniqueness => {:case_sensitive => false} 

  # def self.by_karma
  #   joins(:karma_points).group('users.id').order('SUM(karma_points.value) DESC')
  # end

  def self.by_karma
    order('total_karma DESC')
  end

  # def add_to_total_karma(karma_point)
  #   self.total_karma += karma_point.value
  #   puts "I'm adding the #{karma_point.value}"
  #   self.save
  # end

  # def total_karma
  #   self.karma_points.sum(:value)
  # end

  def populate_total_karma
    self.update_attribute(:total_karma, self.karma_points.sum(:value))
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
