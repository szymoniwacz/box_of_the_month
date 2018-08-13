class Payment < ApplicationRecord
  NEW     = :new
  SUCCESS = :success
  FAILED  = :failed

  belongs_to :subscription

  before_create :set_status

  private

  def set_status
    self.status = NEW
  end
end
