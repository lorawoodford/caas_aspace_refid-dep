require 'erb'
require 'net/http'
require 'date'

def generate_ref_id(resource_id)
  begin
    url = URI.parse(AppConfig[:backend_url] + "/caas_next_refid?resource_id=#{resource_id}")
    request = Net::HTTP::Post.new(url.to_s)
    response = Net::HTTP.start(url.host, url.port) {|http|
      http.request(request)
    }
    refid = JSON(response.body)['next_refid']
  rescue
    refid = DateTime.now.strftime('%Q')
  end
  refid
end

if AppConfig.has_key?(:caas_aspace_refid_rule) && AppConfig[:caas_aspace_refid_rule]
  rule_template = ERB.new(AppConfig[:caas_aspace_refid_rule])
  ArchivalObject.auto_generate(:property => :ref_id,
                               :generator => proc {|json|
                                 component = json
                                 resource_id = JSONModel::JSONModel(:resource).id_for(json['resource']['ref'])
                                 resource = Resource.to_jsonmodel(resource_id)
                                 rule_template.result(binding())
                               },
                               :only_on_create => true)
end
