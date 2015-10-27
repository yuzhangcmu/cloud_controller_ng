require 'spec_helper'
require 'builders/app_update_request_builder'

module VCAP::CloudController
  describe AppUpdateRequestBuilder do
    let(:request_builder) { AppUpdateRequestBuilder.new }
    context 'lifecycle' do
      let(:app_model) { AppModel.make }
      let!(:app_lifecycle_data) { BuildpackLifecycleDataModel.make(app: app_model) }
      let(:app_buildpack) { app_lifecycle_data.buildpack }
      let(:app_stack) { app_lifecycle_data.stack }

      it 'does not modify the passed-in params' do
        params = {foo: 'bar'}
        request = request_builder.build(params, app_lifecycle_data)

        expect(request).to_not eq(params)
        expect(params).to eq(foo: 'bar')
      end

      context 'when the lifecycle type is buildpack' do
        let(:params) {
          {
            'lifecycle' => {
              'type' => 'buildpack',
              'data' => lifecycle_data
            }
          }
        }
        let(:built_data) { request_builder.build(params, app_lifecycle_data)['lifecycle']['data'] }

        context 'and lifecycle data is complete' do
          let(:lifecycle_data) { { 'buildpack' => 'cool-buildpack', 'stack' => 'cool-stack' } }

          it 'uses the user-specified lifecycle data' do
            expect(built_data).to eq(lifecycle_data)
          end
        end

        context 'and lifecycle data is incomplete' do


          context 'buildpack is missing' do
            let(:lifecycle_data) { {'stack' => 'my-stack'} }

            it 'uses the user-specified stack and the app buildpack' do
              expect(built_data).to eq('buildpack' => app_buildpack, 'stack' => 'my-stack')
            end
          end

          context 'stack is missing' do
            let(:lifecycle_data) { {'buildpack' => 'my-buildpack'} }

            it 'uses the app stack and user specified buildpack' do
              expect(built_data).to eq('buildpack' => 'my-buildpack', 'stack' => app_stack)
            end
          end

          context 'when lifecycle is provided but data is empty' do
            let(:lifecycle_data) { {} }

            it 'fills in app lifecycle data' do
              expect(built_data).to eq('buildpack' => app_buildpack, 'stack' => app_stack)
            end
          end
        end
      end

      context 'when the user does not request the lifecycle' do
        let(:params) {
          {
            'environment_variables' => {
              'CUSTOM_ENV_VAR' => 'hello'
            }
          }
        }
        let(:desired_assembled_request) {
          {
            'environment_variables' => {
              'CUSTOM_ENV_VAR' => 'hello'
            },
            'lifecycle' => {
              'type' => 'buildpack',
              'data' => {
                'buildpack' => app_buildpack,
                'stack' => app_stack
              }
            }
          }
        }
        it 'fills in everything' do
          assembled_request = request_builder.build(params, app_lifecycle_data)
          expect(assembled_request).to eq(desired_assembled_request)
        end
      end

      context 'when lifecycle is provided without the data key' do
        let(:params) do
          {
            'environment_variables' => {
              'CUSTOM_ENV_VAR' => 'hello'
            },
            'lifecycle' => {
              'type' => 'buildpack'
            }
          }
        end
        let(:desired_assembled_request) do
          {
            'environment_variables' => {
              'CUSTOM_ENV_VAR' => 'hello'
            },
            'lifecycle' => {
              'type' => 'buildpack'
            }
          }
        end

        it 'does not replace anything' do
          assembled_request = request_builder.build(params, app_lifecycle_data)
          expect(assembled_request).to eq(desired_assembled_request)
        end
      end

      context 'when lifecycle is provided without a type' do
        let(:params) do
          {
            'environment_variables' => {
              'CUSTOM_ENV_VAR' => 'hello'
            },
            'lifecycle' => {
              'foo' => 'bar',
              'data' => {'cool' => 'data'}
            }
          }
        end

        it 'does not replace anything' do
          expect(request_builder.build(params, app_lifecycle_data)['lifecycle']).to eq('foo' => 'bar', 'data' => {'cool' => 'data'})
        end
      end
    end
  end
end
