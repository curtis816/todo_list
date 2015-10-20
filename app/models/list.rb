class List < ActiveRecord::Base
  validates :title, presence: true

  has_many :items
  belongs_to :Owner, class_name: "User",foreign_key: :id

  def editable_by?(user)
   user && user.id == user_id
  end
end
