require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  describe 'GET /questions/:id' do
    subject { get "/questions/#{question.id}" }
    it 'show question' do
      sign_in user
      subject
      expect(response.status).to eq 200
    end
  end
  describe 'GET /questions/new' do
    subject { get '/questions/new' }
    it 'show new question page' do
      sign_in user
      subject
      expect(response.status).to eq 200
    end
  end
  describe 'POST /questions' do
    let(:params) { { question: { title: 'hoge', body: 'fuga' } } }
    subject { post '/questions', params: params }
    it 'create new question' do
      sign_in user
      expect {
        subject
      }.to change { Question.count }
      expect(response.status).to eq 302
    end
  end
end
