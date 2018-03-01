require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe '#show' do
    context 'ユーザーが存在する場合' do
      it 'ユーザーページを表示すること' do
        get :show, params: { id: user.id }
        expect(:response).to render_template :show
      end
    end

    context 'ユーザーが存在しない場合' do
      it 'ルートにリダイレクトされること' do
        get :show, params: { id: 0 }
        expect(:response).to redirect_to root_path
      end
    end
  end

  describe '#edit' do
    before do
      login_as_user(user)
    end

    context 'ユーザーが存在する場合' do
      context '自身を編集する場合' do
        it 'ユーザーの編集ページを表示すること' do
          get :edit, params: { id: user.id }
          expect(:response).to render_template :edit
        end
      end

      context '自分以外のユーザーを編集しようとする場合' do
        it 'ルートにリダイレクトされること' do
          another_user = create(:user)
          get :edit, params: { id: another_user.id }
          expect(:response).to redirect_to root_path
        end
      end
    end

    context 'ユーザーが存在しない場合' do
      it 'ルートにリダイレクトされること' do
        get :edit, params: { id: 0 }
        expect(:response).to redirect_to root_path
      end
    end
  end

  describe '#update' do
    before do
      login_as_user(user)
    end

    context 'ユーザーが存在する場合' do
      let(:params) do
        {
          user: {
            name: 'Mike',
            email: 'mike@gmail.com',
            website: 'http://localhost:3000/',
            profile: 'はじめまして'
          }
        }
      end

      context '自身を編集する場合' do
        it 'ユーザーを更新できること' do
          patch :update, params: params.merge(id: user.id)
          user.reload
          expect(user.name).to eq params[:user][:name]
          expect(user.email).to eq params[:user][:email]
          expect(user.website).to eq params[:user][:website]
          expect(user.profile).to eq params[:user][:profile]
        end
      end

      context '自分以外のユーザーを編集しようとする場合' do
        it 'ルートにリダイレクトされること' do
          another_user = create(:user)
          patch :update, params: params.merge(id: another_user.id)
          expect(:response).to redirect_to root_path
        end
      end
    end
  end

  describe '#edit_password' do
    before do
      login_as_user(user)
    end

    context 'ユーザーが存在する場合' do
      context '自身を編集する場合' do
        it 'ユーザーの編集ページを表示すること' do
          get :edit_password, params: { id: user.id }
          expect(:response).to render_template :edit_password
        end
      end

      context '自分以外のユーザーを編集しようとする場合' do
        it 'ルートにリダイレクトされること' do
          another_user = create(:user)
          get :edit, params: { id: another_user.id }
          expect(:response).to redirect_to root_path
        end
      end
    end

    context 'ユーザーが存在しない場合' do
      it 'ルートにリダイレクトされること' do
        get :edit, params: { id: 0 }
        expect(:response).to redirect_to root_path
      end
    end
  end

  describe '#update_password' do
    before do
      login_as_user(user)
    end

    context 'ユーザーが存在する場合' do
      let(:params) do
        {
          user: {
            current_password: 'password',
            password: 'new_password',
            password_confirmation: 'new_password'
          }
        }
      end

      context '自身を編集する場合' do
        it 'ユーザーを更新できること' do
          password = user.encrypted_password
          patch :update_password, params: params.merge(id: user.id)
          user.reload
          expect(user.encrypted_password).not_to eq password
        end
      end

      context '自分以外のユーザーを編集しようとする場合' do
        it 'ルートにリダイレクトされること' do
          another_user = create(:user)
          patch :update_password, params: params.merge(id: another_user.id)
          expect(:response).to redirect_to root_path
        end
      end
    end
  end
end
