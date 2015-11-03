require 'rails_helper'
require 'action_dispatch/middleware/params_parser'

module VCAP::CloudController
  describe ErrorsController, type: :controller do
    describe '#not_found' do
      it 'returns an error' do
        get :not_found

        expect(response.status).to eq(404)
        expect(response.body).to include('CF-NotFound')
      end
    end

    describe '#internal_error' do
      it 'returns an error' do
        get :internal_error

        expect(response.status).to eq(500)
        expect(response.body).to include('CF-ServerError')
      end
    end

    describe '#bad_request' do
      it 'returns an error' do
        get :bad_request

        expect(response.status).to eq(400)
        expect(response.body).to include('CF-InvalidRequest')
      end

      context 'when the json is invalid' do
        before do
          @request.env['action_dispatch.exception'] = ActionDispatch::ParamsParser::ParseError.new(nil, nil)
        end

        it 'it returns an error' do
          get :bad_request

          expect(response.status).to eq(400)
          expect(response.body).to include('invalid request body')
        end
      end
    end
  end
end
