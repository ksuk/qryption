require 'rails_helper'
RSpec.describe WelcomeController, type: :controller do
  render_views

  let(:user) { create(:user) }

  context 'unlogin' do
    describe 'index' do
      subject { get :index }
      it { should render_template :unlogin }
    end
  end

  context 'login' do
    before { sign_in user }
    describe 'index' do
      subject { get :index }
      it { should render_template :index }
    end
  end
end
