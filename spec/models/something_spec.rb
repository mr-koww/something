require_relative  '../rails_helper'

describe Something, type: :model do
  it { should validate_presence_of(:title) }
end
