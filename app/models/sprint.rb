class Sprint < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :name, :start_date, :end_date, :user, presence: true

  validate :end_date_after_start_date

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "deve ser maior ou igual à data de início")
    end
  end
end
