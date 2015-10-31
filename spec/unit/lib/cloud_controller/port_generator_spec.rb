require 'spec_helper'

module VCAP::CloudController
  describe PortGenerator do
    let(:routing_api_client) { double('routing_api', router_group: router_group) }
    let(:router_group) { double(:router_group, type: router_group_type, guid: router_group_guid) }
    let(:router_group_type) { 'tcp' }
    let(:router_group_guid) { 'router-group-guid' }
    let(:domain_guid) { domain.guid }
    let(:domain) { SharedDomain.make(router_group_guid: router_group_guid) }
    let(:generator) { PortGenerator.new({ 'domain_guid' => domain_guid }) }

    describe 'generate_port' do

      it 'generates a port' do
        port = generator.generate_port

        expect( (1024..65535).include?(port) ).to eq(true)
      end

      it 'runs out of ports' do
        for i in 1..3 do
          port = generator.generate_port(1024, 1026)
          Route.make(domain: domain, port: port)
        end

        port = generator.generate_port(1024, 1026)
        expect(port).to eq(-1)
      end

      context 'when there are multi router groups' do
        let(:router_group_guid2) { 'router-group-guid2' }
        let(:router_group2) { double(:router_group2, type: router_group_type, guid: router_group_guid2) }
        let(:domain_in_different_router_group) { SharedDomain.make(router_group_guid: router_group_guid2) }
        let(:generator2) { PortGenerator.new({ 'domain_guid' => domain_in_different_router_group.guid }) }

        it 'hands out the same port for multiple router groups' do
          Route.make(domain: domain, port: 60001)
          Route.make(domain: domain_in_different_router_group, port: 60001)

          port = generator.generate_port(60001, 60002)
          port2 = generator2.generate_port(60001, 60002)

          expect(port).to eq(port2)
        end
      end
    end
  end
end
