require 'rails_helper'
RSpec.describe QuestionsController, type: :controller do
  render_views

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  before { sign_in user }

  describe '.show' do
    subject { get :show, params: { id: question.id } }
    it { expect(response).to have_http_status(:ok) }
  end

  describe '.new' do
    subject { get :new }
    it { expect(response).to have_http_status(:ok) }
  end

  describe '.create' do
    subject { get :create, params: { question: { title: 'hoge', body: 'piyo' } } }
    it { expect(response).to have_http_status(:ok) }
    it { expect { subject }.to change { Question.count } }
  end
end
