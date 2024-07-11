require 'spec_helper'

describe 'CAAS ref id plugin' do
  context 'when no resource_id is provided' do
    it 'throws an error' do
      post '/caas_next_refid', params = { }
      expect(last_response).not_to be_ok
      expect(last_response.status).to eq(400)
      expect(last_response.body).to include('error')
    end
  end

  context 'when a resource_id is provided' do
    let(:resource) { create_resource }
    let(:next_refid) { post '/caas_next_refid', params = { "resource_id" => resource.id} }

    it 'creates a next_refid' do
      next_refid

      expect(last_response).to be_ok
      expect(last_response.status).to eq(200)
    end

    context 'when ref_ids exist' do
      before do
        next_refid
      end

      it 'lists them when asked' do
        get '/caas_aspace_refid'

        expect(last_response).to be_ok
        expect(JSON(last_response.body)[0]).to include({"jsonmodel_type" => "caas_next_refid"})
      end
    end
  end
end
