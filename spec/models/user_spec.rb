require "rails_helper"

RSpec.describe User, type: :model do
  describe "Associations" do
    it {should have_many(:records).dependent(:destroy)}
    it {should have_many(:exams).dependent(:destroy)}
    it {should have_many(:results).dependent(:destroy)}
  end

  describe "Validations" do
    context "when field email" do
      subject{FactoryBot.build(:user)}
      it {should validate_presence_of(:email)}
      it {should validate_length_of(:email).is_at_most(Settings.user.email.max_length)}
      it {should validate_uniqueness_of(:email)}
    end

    context "when field name" do
      subject{FactoryBot.build(:user)}
      it {should validate_presence_of(:name)}
      it {should validate_length_of(:name).is_at_most(Settings.user.name.max_length)}
    end

    context "when field password" do
      subject{FactoryBot.build(:user)}
      it {should validate_length_of(:password).is_at_least(Settings.user.password.min_length)}
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

    describe ".by_between_date" do
      context "when found by date to date" do
        it "should search user" do
          expect(User.by_between_date("2022-06-05","2023-06-11").pluck(:id)).to eq [user_1.id]
        end
      end

      context "when not found" do
        it "should be empty" do
          expect(User.by_between_date("", "").pluck(:id)).to eq []
        end
      end
    end

    describe ".by_created_at" do
      context "when end date blank" do
        it "should search user" do
          expect(User.by_created_at("2022-06-11", "").pluck(:id)).to eq [user_1.id]
        end
      end

      context "when start date blank" do
        it "should search user" do
          expect(User.by_created_at("", "2023-06-11").pluck(:id)).to eq [user_1.id]
        end
      end

      context "when found date to date" do
        it "should search user" do
          expect(User.by_created_at("2022-06-05", "2023-06-11").pluck(:id)).to eq [user_1.id]
        end
      end

      context "when end start date and end date blank" do
        it "should search user" do
          expect(User.by_created_at("", "").pluck(:id)).to eq User.all.ids
        end
      end
    end

    describe "Public instance methods" do
      let(:user){FactoryBot.create :user}

      describe "responds to its methods" do
        it {is_expected.to respond_to :remember}
        it {is_expected.to respond_to :authenticated?}
        it {is_expected.to respond_to :forget}
      end

      describe "method #remember" do
        it "returns true" do
          expect(user.remember).to be true
        end
      end

      describe "method #forget" do
        it "returns true" do
          expect(user.forget).to be true
        end
      end

      describe "method #authenticated?" do
        it "returns true when correct token" do
          token = User.new_token
          remember_token = User.digest token
          user.update_column :remember_digest, remember_token

          expect(user.authenticated?(:remember, token)).to be true
        end

        it "returns false when uncorrect token" do
          remember_token = User.digest User.new_token
          user.update_column :remember_digest, remember_token

          expect(user.authenticated?(:remember, "unkown")).to be false
        end

        it "returns false when digest for token is nil" do
          expect(user.authenticated?(:remember, "unknown")).to be false
        end
      end
    end

    describe "Public class methods" do
      subject {User}

      describe "responds to its methods" do
        it {is_expected.to respond_to :new_token}
        it {is_expected.to respond_to :digest}
      end

      describe "method .new_token" do
        it "returns a token with length is 22" do
          expect(subject.new_token.size).to eq 22
        end
      end

      describe "method .digest" do
        it "returns a digest with length is 60 when min_cost is present " do
          ActiveModel::SecurePassword.min_cost = 10
          expect(subject.digest(subject.new_token).size).to eq 60
        end

        it "returns a digest with length is 60 when min_cost is nil " do
          ActiveModel::SecurePassword.min_cost = nil
          expect(subject.digest(subject.new_token).size).to eq 60
        end
      end
    end
  end
end
