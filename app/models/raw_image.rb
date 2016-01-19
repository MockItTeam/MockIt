class RawImage < ActiveRecord::Base
  enum status: { pending: 0, processed: 1, error: 2 }

  belongs_to :user

  validates_presence_of :user
  validates_associated :user
  
  # TODO: Limitation of uploaded images
  # TODO: Validate width, height, size

end
