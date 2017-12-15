class Event < ActiveRecord::Base
  belongs_to :user
  has_many :goings, dependent: :destroy
  has_many :users, through: :goings

  validates :name, :location, :state, presence: true
  validates :date, presence: true
  validate :crack

  
  def crack
    if date.present? && date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end

end
