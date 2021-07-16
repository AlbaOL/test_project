require 'rails_helper'

RSpec.describe Api::V1::LicensesController, type: :controller do
    context 'when the user is authenticated' do
        describe 'licenses actions' do
            let(:user) { create(:user) }
            let(:license) { create(:license) }
          
            before do
                sign_in user
            end
        
            it 'returns all licenses' do
                get :index, params: {}
                expect(response).to have_http_status(:success)
                expect(response.body.count).to eq(2)
            end
            
            it 'generate pdf' do
                post :print_license, params: {}
                expect(response).to have_http_status(:success)
            end
        end
    end
end
