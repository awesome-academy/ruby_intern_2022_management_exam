require "rails_helper"

RSpec.describe Admin::UsersController, type: :controller do
  include SessionsHelper

  let(:admin){FactoryBot.create :user, role: "admin"}
  let!(:user_1){FactoryBot.create :user}
  let!(:user_2){FactoryBot.create :user}

  before do
    log_in admin
  end

  describe "GET users#index" do
    it "gets all users" do
      get :index
      expect(assigns(:users).pluck(:id)).to eq([user_1.id, user_2.id, admin.id])
    end

    it "gets user by params" do
      params = {
        name: user_1.name,
        email: user_1.email
      }
      get :index, params: params, xhr: true
      expect(assigns(:users).pluck(:id)).to eq [user_1.id]
    end
  end

  describe "DELETE #destroy" do
    context "when delete success" do
      it "should delete record user" do
        expect {delete :destroy, xhr: true, params:{id: user_1.id}}.to change { User.count }.by(-1)
      end

      it "should flash success" do
        delete :destroy, xhr: true, params:{id: user_1.id}
        expect(flash.now[:success]).to eq I18n.t("admin.users.destroy.message_success")
      end
    end

    context "when not find user" do
      it "should flash danger not find" do
        delete :destroy, xhr: true, params:{id: ""}
        expect(flash.now[:danger]).to eq I18n.t("admin.users.destroy.messgae_fail")
      end
    end

    context "when delete fail" do
      let(:user_3){FactoryBot.build_stubbed(:user)}

      before do
        allow(user_3).to receive(:destroy).and_return(false)
      end

      it "should flash danger not destroy" do
        delete :destroy, xhr: true, params: {id: user_3.id}
        expect(flash[:danger]).to eq I18n.t("admin.users.destroy.messgae_fail")
      end
    end
  end
end
