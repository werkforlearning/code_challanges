# Field

# description
# due_date
# priority
# status

class Task < ApplicationRecord
  belongs_to :user

  validates :description, presence: true
  validates :due_date, presence: true

  after_initialize do
    self.due_date ||= 3.days.from_now
  end

end
