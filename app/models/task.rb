class Task < ApplicationRecord
  belongs_to :sprint

  validates :title, :status, :story_points, :sprint, presence: true

  VALID_STATUSES = [
    "a_fazer",
    "fazendo",
    "em_revisao",
    "concluida"
  ]
  validates :status, inclusion: { in: VALID_STATUSES }
end
