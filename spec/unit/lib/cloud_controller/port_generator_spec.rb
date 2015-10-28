require 'spec_helper'

module VCAP::CloudController
  describe PortGenerator do
    describe 'generate_port' do
      let(:generator) { PortGenerator.new(attrs) }

      let(:attrs) do
        {
          'router_group_id' => 'guid!',
          'domain_guid'      => 'guid!'
        }
      end

      it 'generates a port' do
        port = generator.generate_port
        expect( (1...65535).include?(port) ).to eq(true)
      end

      it "doesn't give back a port that is already taken on that domain / router group" do
        #some complicated setup here

      end

    end
  end
end
