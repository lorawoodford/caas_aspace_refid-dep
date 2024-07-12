require 'spec_helper'

describe 'CAAS ref id plugin' do
  context 'when no resource_id is provided' do
    it 'throws an error' do
      post '/plugins/caas_next_refid', params = { }

      expect(last_response).not_to be_ok
      expect(last_response.status).to eq(400)
      expect(last_response.body).to include('error')
    end
  end

  context 'when a resource_id is provided' do
    let(:resource) { create_resource }

    it 'creates a next_refid' do
      post '/plugins/caas_next_refid', params = { "resource_id" => resource.id}

      expect(last_response).to be_ok
      expect(last_response.status).to eq(200)
    end
  end
end
