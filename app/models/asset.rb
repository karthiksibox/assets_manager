class Asset < ActiveRecord::Base
  attr_accessible :description, :status, :asset_type_id, :employee_id, :bar_code, :serial_number
  belongs_to :asset_type
  belongs_to :user
  belongs_to :project

  VALID_STATUSES = ['Assigned', 'In Stock', 'Out of order']

  validates :status, :asset_type,
            :presence => true

  def self.by_bar_code(bar_code)
    where(:bar_code =>  bar_code).first
  end

  def assigned_to?(user)
    user.assets.include?(self)
  end

  def unassign!
    self.user_id = nil
    self.project_id = nil
    self.save!
  end

  def assign!(user)
    self.user = user
    self.save!
  end
end
