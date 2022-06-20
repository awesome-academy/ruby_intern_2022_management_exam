require "rails_helper"

RSpec.describe SubjectsController, type: :controller do
  let!(:user_1){FactoryBot.create :user}

  before(:each) do
    sign_in user_1
  end

  describe 'GET #index' do
    let!(:subject_1){FactoryBot.create :subject}
    it "gets all subject" do
      get :index
      expect(assigns(:subjects)).to eq([subject_1])
    end
    context 'ransack search by name' do

      it "should find subject" do
        expect(Subject.ransack(name_cont: subject_1.name).result.pluck(:id)).to eq [subject_1.id]
      end

      it "not find subject" do
        expect(Subject.ransack(name_cont: "aaaa").result.pluck(:id)).to eq []
      end
    end
  end
end
