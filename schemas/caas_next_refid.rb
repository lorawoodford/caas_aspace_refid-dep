{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",
    "uri" => "/plugins/caas_next_refid",
    "properties" => {
      "uri" => {
        "type" => "string",
        "required" => false},
      "resource_id" => {
        "type" => "integer",
        "ifmissing" => "error"
      },
      "next_refid" => {
        "type" => "integer",
        "ifmissing" => "error"
      }
    },

    "additionalProperties" => false,
  },
}
