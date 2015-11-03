require 'spec_helper'
require 'request_logs'

module CloudFoundry
  module Middleware
    describe RequestLogs do
      pending 'add tests for request logs'

      # This test was stolen from the original front_controller_spec
      # and should only be used for reference
      describe 'logging' do
        let(:app) { described_class.new({ https_required: true }, token_decoder) }
        let(:token_decoder) { double(:token_decoder, decode_token: { 'user_id' => 'fake-user-id' }) }

        context 'get request' do
          before do
            allow(Steno).to receive(:logger).with(anything).and_return(fake_logger)
          end

          it 'logs request id and status code for all requests' do
            get '/test_front_endpoint', '', {}
            request_id = last_response.headers['X-Vcap-Request-Id']
            request_status = last_response.status.to_s
            expect(fake_logger).to have_received(:info).with("Completed request, Vcap-Request-Id: #{request_id}, Status: #{request_status}")
          end

          it 'logs request id and user guid for all requests' do
            get '/test_front_endpoint', '', {}
            request_id = last_response.headers['X-Vcap-Request-Id']
            expect(fake_logger).to have_received(:info).with("Started request, Vcap-Request-Id: #{request_id}, User: fake-user-id")
          end
        end
      end
    end
  end
end
