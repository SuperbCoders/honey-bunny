module Settings
  class Social < Settingslogic
    source "#{Rails.root}/config/social.yml"
    namespace Rails.env
  end
end