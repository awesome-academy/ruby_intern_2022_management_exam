require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let!(:user_1){FactoryBot.create :user}

  before(:each) do
    sign_in user_1
  end

  describe 'GET #show' do
    context "user is present" do
      it "render show view" do
        get :show, params: {id: user_1.id}
        expect(response).to render_template "show"
      end
    end

    context "user exam is nil" do
      it "redirect to root" do
        get :show, params: {id: 1}
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #new' do
    it "gets user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST #create' do
    let!(:user_params){FactoryBot.attributes_for :user}
    context "when create success" do
      it "should create new user" do
        expect do
          post :create, params:{user: user_params}
        end.to change{User.count}.by 1
      end
      it "should redirect to home" do
        post :create, params:{user: user_params}
        expect(response).to redirect_to root_path
      end
      it "should flash success" do
        post :create, params:{user: user_params}
        expect(flash[:success]).to eq I18n.t("users.create.wellcome")
      end
    end

    context "when create fail" do
      it "should flash fail" do
        post :create, params:{user: {name: ""}}
        expect(flash[:danger]).to eq I18n.t("users.create.error_message")
      end
      it "should render new" do
        post :create, params:{user: {name: ""}}
        expect(response).to render_template :new
      end
    end
  end

end
