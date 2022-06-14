require "rails_helper"

RSpec.describe User, type: :model do
  describe "Associations" do
    it {should have_many(:records).dependent(:destroy)}
    it {should have_many(:exams).dependent(:destroy)}
    it {should have_many(:results).dependent(:destroy)}
  end

  describe "Validations" do
    context "when field name" do
      subject{FactoryBot.build(:user)}
      it {should validate_presence_of(:name)}
      it {should validate_length_of(:name).is_at_most(Settings.user.name.max_length)}
    end

    context "when field email" do
      subject{FactoryBot.build(:user)}
      it {should validate_presence_of(:email)}
      it {should validate_uniqueness_of(:email).ignoring_case_sensitivity}
    end

    context "when field password" do
      subject{FactoryBot.build(:user)}
      it {should validate_length_of(:password).is_at_least(Settings.user.password.min_length)}
      it {should validate_length_of(:password).is_at_most(Settings.user.password.max_length)}
      it {should validate_confirmation_of(:password)}
    end
  end

  describe "Enums" do
    it {should define_enum_for(:role).with([:user, :admin])}
  end

  describe "Scope" do
    let(:user_1){FactoryBot.create :user}
    let(:subject_1){FactoryBot.create :subject}
    let!(:exam_1){FactoryBot.create :exam, user_id: user_1.id, subject_id: subject_1.id}

    describe ".by_name" do
      context "when found" do
        it "search user by name" do
          expect(User.by_name(user_1.name)).to eq [user_1]
        end
      end

      context "when not found" do
        it "should be empty" do
          expect(User.by_name("ccc")).to eq []
        end
      end
    end

    describe ".by_email" do
      context "when found" do
        it "should search user" do
          expect(User.by_email(user_1.email)).to eq [user_1]
        end
      end

      context "when not found" do
        it "should be empty" do
          expect(User.by_email("ccc")).to eq []
        end
      end
    end

    describe ".by_start_date" do
      context "when found by start date" do
        it "should search user" do
          expect(User.by_start_date("2022-06-08").pluck(:id)).to eq [user_1.id]
        end
      end

      context "when not found" do
        it "should be empty" do
          expect(User.by_start_date("2023-06-11").pluck(:id)).to eq []
        end
      end
    end

    describe ".by_end_date" do
      context "when found by end date" do
        it "should search user" do
          expect(User.by_end_date("2023-06-11").pluck(:id)).to eq [user_1.id]
        end
      end

      context "when not found" do
        it "should be empty" do
          expect(User.by_end_date("2022-06-05").pluck(:id)).to eq []
        end
      end
    end
  end
end
