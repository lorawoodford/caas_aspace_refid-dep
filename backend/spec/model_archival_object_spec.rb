require 'spec_helper'

describe 'ArchivalObject model' do
  let(:resource) { create_resource({ :ead_id => 'my.eadid' }) }
  let(:archival_object) do
    build(:json_archival_object,
           'ref_id' => nil,
           'resource': {
             'ref': "/repositories/2/resources/#{resource.id}"
           }
          )
  end

  context 'when the next_refid endpoint returns an id' do
    let(:body) { {"resource_id": resource.id, "next_refid": 40} }
    let(:response) { instance_double(Net::HTTPResponse) }

    before do
      allow(Net::HTTP).to receive(:start).and_return(response)
      allow(response).to receive(:body).and_return(body.to_json)
    end

    describe '#generate_ref_id' do
      it 'returns the refid' do
         expect(generate_ref_id(resource.id)).to eq(40)
       end
    end

    describe '#auto_generate' do
      it 'auto generates ref_id' do
        archival_object.save

        expect(archival_object.ref_id).to eq('my.eadid_ref40')
      end
    end
  end

  context 'when the next_refid endpoint fails to return a ref_id' do
    let(:refid_fallback) { DateTime.now.strftime('%s')[0..-1] }

    describe '#generate_ref_id' do
      it 'returns a unique date string' do
         expect(generate_ref_id(resource.id)).to start_with(refid_fallback)
       end
    end

    describe '#auto_generate' do
      it 'auto generates ref_id from the unique date string' do
        archival_object.save

        expect(archival_object.ref_id).to start_with("my.eadid_ref#{refid_fallback}")
      end
    end
  end
end
