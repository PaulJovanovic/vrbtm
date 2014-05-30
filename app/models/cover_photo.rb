class CoverPhoto < Asset
  has_attached_file :attachment, :styles => { :small => "200x80#", :medium => "800x320#" }
  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/
end
