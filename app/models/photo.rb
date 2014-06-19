require 'RMagick'
include Magick

class Photo < Asset
  has_attached_file :attachment, :styles => { :small => "256x256#", :medium => "394x394#" }
  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/

  def self.from_attributes(attributes)
    background_color = attributes["background_color"]
    font_size = attributes["font_size"]
    quotation_marks = attributes["quotation_marks"]
    words = attributes["words"]
    image = Image.new(394, 394) do
      self.background_color = background_color
    end

    quotation_left = ImageList.new
    url_quotation_left = open("http://s3.amazonaws.com/vrbtm2/assets/quotation_left_white.png")
    quotation_left.from_blob(url_quotation_left.read)

    quotation_right = ImageList.new
    url_quotation_right = open("http://s3.amazonaws.com/vrbtm2/assets/quotation_right_white.png")
    quotation_right.from_blob(url_quotation_right.read)

    quotation_size = words[0]["left"] - quotation_marks[0]["left"] - 5
    complete_image = ImageList.new
    complete_image << image.composite(quotation_left.resize_to_fill(quotation_size), quotation_marks[0]["left"], quotation_marks[0]["top"], OverCompositeOp).composite(quotation_right.resize_to_fill(quotation_size), quotation_marks[1]["left"], quotation_marks[1]["top"], OverCompositeOp)

    draw = Draw.new
    draw.pointsize = font_size
    draw.font_family = "Helvetica"
    draw.gravity = NorthGravity
    draw.fill = "#FFFFFF"
    draw.font_weight = 900
    draw.stroke = "none"
    words.each do |word|
      metrics = draw.get_type_metrics(word["text"])
      draw.annotate(complete_image, metrics.width,metrics.height,word["left"],word["top"], word["text"])
    end

    complete_image.format = "png"
    temp_image = Tempfile.new(['image_data', '.png'])
    temp_image.binmode
    temp_image.write(complete_image.to_blob)
    photo = Photo.new(attachment: temp_image)
    temp_image.close
    photo
  end
end
