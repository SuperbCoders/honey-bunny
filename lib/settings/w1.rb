module Settings
  class W1 < Settingslogic
    source "#{Rails.root}/config/w1.yml"
    namespace Rails.env
  end
end
