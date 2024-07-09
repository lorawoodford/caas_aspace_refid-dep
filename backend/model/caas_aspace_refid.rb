class CaasAspaceRefid < Sequel::Model(:caas_aspace_refid)
  include ASModel

  set_model_scope :global
  corresponds_to JSONModel(:caas_next_refid)

end
