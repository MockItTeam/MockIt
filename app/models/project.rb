class Project < ActiveRecord::Base
  enum status: { active: 0 }

  has_many :invitations
  has_and_belongs_to_many :members, join_table: "projects_users"
  belongs_to :owner, foreign_key: "user_id", class_name: "User"

  validates_presence_of :name, :members, :owner
  validates_associated :invitations, :members

  validates :name, length: { in: 3..20 }
  validates :name, format: { with: /\A[a-zA-Z0-9]+\z/,
    message: "Only a-z, A-Z, 0-9 allowed" }

  validate :project_owned_count_per_user_within_limit
  validate :project_name_uniqueness_per_user

  def project_owned_count_per_user_within_limit
    limit = 100
    if self.owner.projects.count >= limit
      errors.add(:base, "Project count per user exceeded allowed maximum: #{limit}")
    end
  end

  def project_name_uniqueness_per_user
    if self.owner.projects.find_by(name: self.name)
      errors.add(:base, "Project's name must be unique per user")
    end
  end
  
end
