class Task < ActiveRecord::Base
  include AASM

  belongs_to :node
  belongs_to :attachable, polymorphic: true
  has_many :permissions, as: :resourceable, dependent: :destroy
  validates_presence_of :execute_at, :code

  enum status: {
    waiting: 0,
    running: 1,
    failed:  2,
    done:    3
  }

  aasm column: :status, enum: true do
    state :waiting, initial: true
    state :running
    state :failed
    state :done

    event :run do
      transitions :from => :waiting, :to =>:running
    end

    event :fail do
      transitions from: :running, to: :failed
    end

    event :completed do
      transitions from: :running, to: :done
    end
  end

end
