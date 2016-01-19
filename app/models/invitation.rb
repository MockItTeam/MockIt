class Invitation < ActiveRecord::Base
  enum status: { pending: 0, accepted: 1, refused: 2, cancelled: 3 }
  
  belongs_to :from, class_name: "User", foreign_key: "from_user_id"
  belongs_to :to, class_name: "User", foreign_key: "to_user_id"
  belongs_to :project
  
  validates_presence_of :from, :to, :project
  validates_associated :form, :to, :project
  
  validates :pending_invitation_count_per_project_within_limit 

  def pending_invitation_count_per_project_within_limit
    LIMIT = 10
    if self.project.invitation.where(status: :pending).count >= LIMIT
      errors.add(:base, "Pending invitation count per project exceeded allowed maximum: #{LIMIT}")
    end
  end

end
