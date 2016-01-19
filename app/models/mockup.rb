class Mockup < ActiveRecord::Base
  enum status: { active: 0 }

  belongs_to :raw_image
  belongs_to :user
  belongs_to :project

  validates_presence_of :user, :project
  validates_associated :raw_image, :user, :project

  validates :name, length: { in: 0..100 }
  validates :name, format: { with: /\A[a-zA-Z0-9\s]+\z/,
    message: "Only a-z, A-Z, 0-9 and white-space allowed" }

  validate :mockup_count_per_project_within_limit

  def mockup_count_per_project_within_limit
    limit = 100
    if self.project.mockups >= limit
      errors.add(:base, "Mockup count per project exceeded allowed maximum: #{limit}")
    end
  end
  
end
