class Project < ApplicationRecord
  belongs_to :author, class_name: 'User' #:user

  has_many :groups_projects, dependent: :destroy
  has_many :groups, through: :groups_projects, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates :duration, presence: true, numericality: { less_than: 10_000 }

  scope :most_recent, -> { order('created_at DESC') }
end
