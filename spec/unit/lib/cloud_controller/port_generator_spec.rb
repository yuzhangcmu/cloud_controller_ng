require 'spec_helper'

module VCAP::CloudController
  describe PortGenerator do
    let(:routing_api_client) { double('routing_api', router_group: router_group) }
    let(:router_group) { double(:router_group, type: router_group_type, guid: router_group_guid) }
    let(:router_group_type) { 'tcp' }
    let(:router_group_guid) { 'router-group-guid' }
    let(:domain_guid) { domain.guid }
    let(:domain) { SharedDomain.make(router_group_guid: router_group_guid) }
    let(:generator) { PortGenerator.new }
    let(:port) {1024}


    describe 'generate_port' do

      it 'generates a port' do
        domain_in_same_router_group = SharedDomain.make(router_group_guid: router_group_guid)
        Route.make(domain: domain_in_same_router_group, port: port)
        port = generator.generate_port
        expect( (1...65535).include?(port) ).to eq(true)
      end

      # it "doesn't give back a port that is already taken on that domain / router group" do
      #   let(:port) {1024}
      #   domain_in_same_router_group = SharedDomain.make(router_group_guid: router_group_guid)
      #   Route.make(domain: domain_in_same_router_group, port: port)
      #
      #   allow(generator).to receive(:generate_port).and_return(port)
      #
      #
      # end

    end
  end
end
