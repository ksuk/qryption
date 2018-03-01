require 'rails_helper'
RSpec.describe QuestionsController, type: :controller do
  render_views

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  context 'ログインしている場合' do
    before { sign_in user }

    describe '#index' do
      before{ 21.times { create(:question, user: user) } }

      it 'indexを描画すること' do
        get :index
        expect(:response).to render_template :index
      end

      it '@questionsを20個取得すること' do
        get :index
        expect(assigns(:questions)).not_to be_blank
        expect(assigns(:questions).count).to eq 20
      end
    end

    describe '.show' do
      subject { get :show, params: { id: question.id } }
      it { expect(response).to have_http_status(:ok) }
    end

    describe '.new' do
      subject { get :new }
      it { expect(response).to have_http_status(:ok) }
    end

    describe '.create' do
      subject { get :create, params: { question: { body: 'piyo' } } }
      it { expect(response).to have_http_status(:ok) }
      it { expect { subject }.to change { Question.count } }
    end
  end

  context '未ログインの場合' do
    describe '#new' do
      it 'top#indexにリダイレクトされること' do
        get :new
        expect(:response).to redirect_to top_index_path
      end
    end

    describe '#create' do
      let(:params) { { question: attributes_for(:question) } }

      it 'top#indexにリダイレクトされること' do
        post :create, params: params
        expect(:response).to redirect_to top_index_path
      end
    end
  end
end
