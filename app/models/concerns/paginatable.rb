module Paginatable
  extend ActiveSupport::Concern

  included do
    default_scope -> { order(created_at: :desc) }

    def self.prev(cursor)
      where('created_at > ?',  cursor)
    end

    def self.next(cursor)
      where('created_at < ?', cursor)
    end
  end
end
