require 'rails_helper'
RSpec.describe AnswersController, type: :controller do
  render_views

  let(:user) { create(:user) }
  let(:user_second) { create(:user) }
  let(:question) { create(:question, user: user_second) }
  before { sign_in user }

  describe '.create' do
    subject { post :create, params: { answer: { body: 'piyo'}, question_id: question.id } }
    it { expect(response).to have_http_status(:ok) }
    it { expect { subject }.to change { Answer.count } }
  end
end
