class User < ActiveRecord::Base
  enum status: { active: 0 }

  has_many :raw_images
  has_many :mockups
  has_many :invitations
  has_and_belongs_to_many :projects

  validates_presence_of :username, :pin
  validates_associated :raw_images, :mockups, :invitations, :projects

  validates :pin, numericality: true, length: { is: 4 }
  validates :username, length: { in: 3..20 }
  validates :username, uniqueness: { case_sensitive: false }
  validates :username, format: { with: /\A[a-z]+\z/,
    message: "Only a-z (lowercase) allowed" }

  validate :user_count_within_limit 

  def user_count_within_limit
    limit = 100
    if User.count >= limit
      errors.add(:base, "User count exceeded allowed maximum: #{limit}")
    end
  end
end
