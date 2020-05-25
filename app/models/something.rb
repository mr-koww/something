class Something < ApplicationRecord
  validates :title, presence: true

  include Paginatable
end
