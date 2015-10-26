module VCAP::CloudController
  class AppCreateRequestBuilder
    def build(params)
      request = params.deep_dup

      request['lifecycle'] = default_lifecycle if request['lifecycle'].nil?

      lifecycle = request['lifecycle']

      # if lifecycle['data']
      if lifec
        lifecycle['data'] = default_lifecycle_data(lifecycle['type']).merge(lifecycle['data'])
      end

      request
    end

    private

    def default_lifecycle
      {
        'type' => 'buildpack',
        'data' => default_lifecycle_data('buildpack')
      }
    end

    def default_lifecycle_data(type)
      default_datas = {
        'buildpack' => {
          'buildpack' => nil,
          'stack' => Stack.default.name
        }
      }

      default_datas[type] || {}
    end
  end
end
