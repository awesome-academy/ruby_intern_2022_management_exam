require "rails_helper"

RSpec.describe Subject, type: :model do
  describe "Associations" do
    it {should have_many(:questions).dependent(:destroy)}
    it {should have_many(:exams).dependent(:destroy)}
  end

  describe "Validations" do
    context "when field name" do
      subject{FactoryBot.build(:subject)}
      it {should validate_presence_of(:name)}
      it {should validate_length_of(:name).is_at_most(Settings.admin.subjects.name_length)}
      it {should validate_uniqueness_of(:name).ignoring_case_sensitivity}
    end

    context "when field duration" do
      subject{FactoryBot.build(:subject)}
      it {should validate_presence_of(:duration)}
    end
  end


  describe "Scope" do
    let(:subject_1){FactoryBot.create :subject}

    describe ".by_name" do
      context "when found" do
        it "search subject by name" do
          expect(Subject.search(subject_1.name)).to eq [subject_1]
        end
      end

      context "when not found" do
        it "should be empty" do
          expect(Subject.search("ccc")).to eq []
        end
      end
    end
  end
end
