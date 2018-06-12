Redmine::Plugin.register :xlsx_export do
  name        'XLSX export dummy'
  author      'Stephan Wiehr'
  description 'demonstrates a problem with axlsx_rails'
  version     '1.0.0'

  # Auxtables (Admin menu)
  menu :admin_menu, :xlsx_export,
       { controller: 'xlsx_exports', action: 'index' },
       html: { class: 'icon settings' }
end

Rails.application.config.after_initialize do
  plugin = Redmine::Plugin.find(:xlsx_export)
  # Determine available features based on Redmine version
  plugin.instance_eval do
    MY_FEATURE = {
      # AXLSX Gem installed (for XLSX export)
      gem_axlsx:               false,
    }

    begin
      require 'acts_as_xlsx'
      require 'axlsx_rails'
      MY_FEATURE[:gem_axlsx] = true
    rescue LoadError => e
      # Ignore
      Rails.logger.info "[INFO] XLSX export feature disabled - #{e.message}"
    end
  end
end

ActionDispatch::Callbacks.to_prepare do
  require 'xlsx_exports/xlsx_exports_hook_listener'
end
