class User < ActiveRecord::Base
  enum status: { active: 0 }

  has_many :raw_images, :mockups, :invitations
  has_many_and_belongs_to :projects

  validates_presence_of :username, :pin
  validates_associated :raw_images, :mockups, :invitations, :projects

  validates :pin, numericality: true, length: { is: 4 }
  validates :username, length: { in: 3..20 }
  validates :username, uniqueness: { case_sensitive: false }
  validates :username, format: { with: /\A[a-z]+\z/,
    message: "Only a-z (lowercase) allowed" }

  validates :user_count_within_limit 

  def user_count_within_limit
    LIMIT = 100
    if User.count >= LIMIT
      errors.add(:base, "User count exceeded allowed maximum: #{LIMIT}")
    end
  end
end
