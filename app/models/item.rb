class Item < ActiveRecord::Base
  belongs_to :group

  def completed?
    !completed_at.blank?
  end
end
