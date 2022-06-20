require "rails_helper"

RSpec.describe Admin::SubjectsController, type: :controller do
  let(:admin){FactoryBot.create :user, role: "admin"}
  let!(:subject_1){FactoryBot.create :subject}

  before do
    sign_in admin
  end

  describe "GET #index" do
    it "gets all subject" do
      get :index
      expect(assigns(:subjects)).to eq([subject_1])
    end
  end

  describe "GET #new" do
    it "gets subject" do
      get :new
      expect(assigns(:subject)).to be_a_new(Subject)
    end
  end

  describe 'POST #create' do
    let!(:subject_params){FactoryBot.attributes_for :subject}
    context "when create success" do
      it "should create new subject" do
        expect do
          post :create, params:{subject: subject_params}
        end.to change{Subject.count}.by 1
      end
      it "should redirect to subject path" do
        post :create, params:{subject: subject_params}
        expect(response).to redirect_to admin_subjects_path
      end
      it "should flash success" do
        post :create, params:{subject: subject_params}
        expect(flash[:success]).to eq I18n.t("admin.subjects.create.success")
      end
    end

    context "when create fail" do
      it "should flash fail" do
        post :create, params:{subject: {name: ""}}
        expect(flash[:danger]).to eq I18n.t("admin.subjects.create.fail")
      end
      it "should render new" do
        post :create, params:{subject: {name: ""}}
        expect(response).to render_template :_subject_form
      end
    end
  end

  describe "PUT #update" do
    context "when update success" do
      let(:subject_params){FactoryBot.attributes_for :subject}
      before do
        put :update, params:{id: subject_1.id, subject: subject_params}
      end
      it "should flash success" do
        expect(flash[:success]).to eq I18n.t("admin.subjects.update.success")
      end
    end
    context "when update fail" do
      it "should flash edit fail" do
        put :update, params:{id: subject_1.id, subject: {name: ""}}
        expect(flash.now[:danger]).to eq I18n.t("admin.subjects.update.fail")
      end
      it "should render edit" do
        patch :update, params:{id: subject_1.id, subject: {name: ""}}
        expect(response).to render_template "_subject_form"
      end
    end
  end

  describe "DELETE #destroy" do
    context "when delete success" do
      it "should delete record user" do
        expect {delete :destroy, xhr: true, params:{id: subject_1.id}}.to change { Subject.count }.by(-1)
      end
      it "should delete the subject" do
        delete :destroy, xhr: true, params:{id: subject_1.id}
        expect(flash.now[:success]).to eq I18n.t("admin.subjects.destroy.success")
      end
    end
    context "when delete fail" do
      let(:subject_1){FactoryBot.build_stubbed(:subject)}
      before do
        allow(subject_1).to receive(:destroy).and_return(false)
        allow(Subject).to receive(:find_by).and_return(subject_1)
      end
      it "should flash danger not destroy" do
        delete :destroy, xhr: true, params: {id: subject_1.id}
        expect(flash.now[:danger]).to eq I18n.t("admin.subjects.destroy.fail")
      end
    end
  end
end
