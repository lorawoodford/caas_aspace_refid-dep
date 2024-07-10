Sequel.migration do
  up do

    create_table(:caas_aspace_refid) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false

      Integer :resource_id, :null => true

      Integer :next_refid, :default => 1, :null => false

      apply_mtime_columns
    end


    alter_table(:caas_aspace_refid) do
      add_foreign_key([:resource_id], :resource, :key => :id)
    end

  end

  down do
    drop_table(:caas_aspace_refid)
  end

end
