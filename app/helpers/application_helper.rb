module ApplicationHelper
  def number_to_shorthand(number)
    number_to_human(number, units: {thousand: "K", million: "M"}, significant_digits: 4)
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
