require 'spec_helper'

describe 'Resource schema extension' do
  it 'includes caas_next_refid object' do
    expect(JSONModel(:resource).schema['properties']).to include('caas_next_refid')
  end
end
