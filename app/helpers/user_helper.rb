module UserHelper
  def avatar_image(obj, size=:medium)
    if obj.avatar
      obj.avatar.url(size)
    else
      "avatar.jpg"
    end
  end

  def cover_image(obj, size=:medium)
    if obj.cover_photo
      obj.cover_photo.url(size)
    else
      ""
    end
  end
end
