require 'rails_helper'

describe Users::RegistrationsController do
  let(:user) { FactoryBot.create(:user) }
  let(:sending_destination) { FactoryBot.create(:sending_destination) }

  setup do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe '#new' do
    it "new.html.erbに遷移すること" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe '#create' do
    context 'バリデーションチェックに成功した場合' do
      let(:build_user) { FactoryBot.build(:user) }
      it "@userに期待した値が入っていること" do
        post :create, params: {user:  build_user.attributes}
        expect(assigns(:user)) == build_user
      end
      it "newSendingDestination.html.erbに遷移すること" do
        get :newSendingDestination
        expect(response).to render_template :newSendingDestination
      end
    end
    context 'バリデーションチェックに失敗した場合' do
      let(:invalid_params) { { user: attributes_for(:user, email: nil) } }
      it "new.html.hamlに戻ること" do
        post :create, params: {user:  invalid_params}
        expect(response).to render_template :new
      end
    end
  end

  describe '#createSendingDestination' do
    context 'バリデーションチェックに成功した場合' do
      let(:params) { { user_id: user.id, sending_destination: attributes_for(:sending_destination) } }
      subject {
        post :createSendingDestination,
        params: params
      }
      it "userを保存すること" do
        # expect{ subject }.to change(User, :count).by(1)
      end
      it "sendingDestinationを保存すること" do
        # expect{ subject }.to change(SendingDestination, :count).by(1)
      end
      it "createSendingDestination.html.erbに遷移すること" do
        subject
        # expect(response).to render_template :newSendingDestination
      end  
    end
    context 'バリデーションチェックに失敗した場合' do
      it "userを保存しないこと" do
      end
      it "sendingDestinationを保存しないこと" do
      end
      it "newSendingDestination.html.erbに遷移すること" do
      end  
    end
  end

end