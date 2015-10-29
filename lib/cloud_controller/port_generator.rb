module VCAP::CloudController
  class PortGenerator

    def generate_port
      possible_ports = Array(1024..65535)
      unavailable_ports = Route.select_map(:port)
      available_ports = possible_ports - unavailable_ports
      available_ports.first
    end

  end
end