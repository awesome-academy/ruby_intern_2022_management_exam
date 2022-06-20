require "rails_helper"

RSpec.describe Exam, type: :model do
  describe "Associations" do
    it {should belong_to(:user)}
    it {should belong_to(:subject)}
    it {should have_one(:result).dependent  (:destroy)}
    it {should have_many(:records).dependent(:destroy)}
    it {should have_many(:questions).dependent(:destroy)}
  end

  describe "Scope" do
    let!(:user_1){FactoryBot.create :user}
    let!(:subject_1){FactoryBot.create :subject}
    let!(:exam_1){FactoryBot.create :exam, user_id: user_1.id, subject_id: subject_1.id}
    let!(:exam_2){FactoryBot.create :exam, user_id: user_1.id, subject_id: subject_1.id}

    describe "sort by created at " do
      it "should sort exam desc" do
        expect(Exam.sort_by_date.pluck(:id)).to eq [exam_2.id, exam_1.id]
      end
    end
  end
end
