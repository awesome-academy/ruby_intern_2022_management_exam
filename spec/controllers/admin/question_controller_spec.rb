require "rails_helper"

RSpec.describe Admin::QuestionsController, type: :controller do
  let(:admin){FactoryBot.create :user, role: "admin"}
  let!(:subject_1){FactoryBot.create :subject}
  let!(:question){FactoryBot.create :question, subject_id: subject_1.id}

  before do
    sign_in admin
  end

  describe "GET #index" do
    it "gets all question" do
      get :index
      expect(assigns(:questions)).to eq([question])
    end
  end

  describe "GET #new" do
    it "gets question" do
      get :new
      expect(assigns(:question)).to be_a_new(Question)
    end
  end

  describe "DELETE #destroy" do
    context "when delete success" do
      it "should delete record user" do
        expect {delete :destroy, xhr: true, params:{id: question.id}}.to change { Question.count }.by(-1)
      end
      it "should delete the subject" do
        delete :destroy, xhr: true, params:{id: question.id}
        expect(flash.now[:success]).to eq I18n.t("admin.questions.destroy.message_success")
      end
    end
    context "when delete fail" do
      let(:question){FactoryBot.build_stubbed(:question)}
      before do
        allow(question).to receive(:destroy).and_return(false)
        allow(Question).to receive(:find_by).and_return(question)
      end
      it "should flash danger not destroy" do
        delete :destroy, xhr: true, params: {id: question.id}
        expect(flash.now[:danger]).to eq I18n.t("admin.questions.destroy.message_fail")
      end
    end
  end
end
