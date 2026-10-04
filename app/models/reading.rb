class Reading < ApplicationRecord
  has_many_attached :images

  validates :title, presence: true
  validates :content, presence: true

  scope :ordered, -> {
    order(Arel.sql("COALESCE(read_at, DATE(created_at)) DESC, created_at DESC"))
  }
end
