class Notification < ActiveRecord::Base
  belongs_to :notifiable, :polymorphic => true
  belongs_to :from_user, class_name: "User"
  belongs_to :to_user, class_name: "User"
end
