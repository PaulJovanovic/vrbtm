class Avatar < Asset
  has_attached_file :attachment, :styles => { :small => "128x128#", :medium => "256x256#" }
  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/
end
