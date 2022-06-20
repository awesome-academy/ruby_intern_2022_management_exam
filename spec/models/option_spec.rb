require "rails_helper"

RSpec.describe Option, type: :model do
  describe "Associations" do
    it {should belong_to(:question)}
    it {should have_many(:records).dependent(:destroy)}
  end
end
