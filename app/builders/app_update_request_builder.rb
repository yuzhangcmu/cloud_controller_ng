module VCAP::CloudController
  class AppUpdateRequestBuilder
    def build(params, app_data)
      request = params.deep_dup

      request['lifecycle'] = default_lifecycle(app_data) if request['lifecycle'].nil?

      lifecycle = request['lifecycle']

      if lifecycle['data']
        lifecycle['data'] = merged_lifecycle_data(lifecycle['type'], app_data, lifecycle['data'])
      end

      request
    end

    private

    def default_lifecycle(app_data)
      {
        'type' => 'buildpack',
        'data' => default_lifecycle_data('buildpack', app_data)
      }
    end

    def merged_lifecycle_data(type, app_data, request_data)
      default_datas = {
        'buildpack' => {
          'buildpack' => default_buildpack(app_data, request_data),
          'stack' => default_stack(app_data,request_data)
        }
      }

      default_datas[type] || {}
    end

    def default_buildpack(app_data, incoming_data={})
      incoming_data.has_key?('buildpack') ? incoming_data['buildpack'] : app_data.buildpack
    end

    def default_stack(app_data, incoming_data={})
      incoming_data.has_key?('stack') ? incoming_data['stack'] : app_data.stack
    end
  end
end
