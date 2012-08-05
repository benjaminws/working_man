require 'rbconfig'

module WorkingMan
  class Provider

    def initialize
      @os = provider_by_os
    end

    def close_applications apps
      @os.close_applications apps
    end

    def launch_applications apps
      @os.launch_applications apps
    end

    def open_urls urls
      @os.open_urls urls
    end

    private
    def provider_by_os
      current_os = RbConfig::CONFIG['host_os']
      os_map = {
        'linux-gnu' => LinuxProvider,
        'darwin' => OSXProvider
      }
      return os_map[current_os]
    end
  end

  class OSXProvider
    def self.close_applications apps
      apps.each do |app_name|
        `osascript -e "tell application \\"#{app_name}\\" to quit"`
      end
    end

    def self.launch_applications apps
      apps.each do |app_name|
        `open -a "#{app_name}.app"`
      end
    end

    def self.open_urls urls
      urls.each do |url|
        `open #{url}`
      end
    end
  end

  class LinuxProvider
    def self.close_applications apps
      apps.each do |app_name|
        `pkill #{app_name}`
      end
    end

    def self.launch_applications apps
      apps.each do |app_name|
        `#{app_name}`
      end
    end

    def self.open_urls urls
      urls.each do |url|
        `xdg-open #{url}`
      end
    end
  end

end
