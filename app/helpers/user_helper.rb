module UserHelper
  def avatar_image(obj, size=:medium)
    if obj.avatar
      obj.avatar.url(size)
    else
      "https://s3.amazonaws.com/vrbtm2/assets/avatar.png"
    end
  end

  def cover_image(obj, size=:medium)
    if obj.cover_photo
      obj.cover_photo.url(size)
    else
      "https://s3.amazonaws.com/vrbtm2/assets/cover.png"
    end
  end
end
