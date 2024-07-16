Rails.application.config.after_initialize do

  Plugins.register_plugin_section(
    Plugins::PluginSubRecord.new(
      'caas_aspace_refid',
      'caas_aspace_refid',
      ['archival_object'],
      {
        cardinality: :zero_to_one,
        heading_text: I18n.t('caas_aspace_refid._singular'),
        show_on_edit: true,
        show_on_readonly: false,
        sidebar_label: I18n.t('caas_aspace_refid._singular'),
        template_name: 'caas_aspace_refid'
      }
    )
  )

end
