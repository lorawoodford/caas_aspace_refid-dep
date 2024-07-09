module CaasNextRefid

  def self.included(base)
    base.one_to_many :caas_aspace_refid

    base.def_nested_record(:the_property => :caas_next_refid,
                            :contains_records_of_type => :caas_next_refid,
                            :corresponding_to_association  => :caas_aspace_refid,
                            :is_array => false)
  end

end
