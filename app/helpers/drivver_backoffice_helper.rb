module DrivverBackofficeHelper
    def backoffice_nav_classes(menu_type)
      is_active = case menu_type
      when :dashboard
                    controller_name == "dashboards"
      when :directorio
                    %w[users organizations vehicles deals events].include?(controller_name)
      when :blog
                    controller_name == "blog_posts"
      else
                    false
      end

      base_classes = "inline-flex items-center gap-1 px-2 h-full border-b-2 text-sm transition-colors focus:outline-none"

      if is_active
        "#{base_classes} border-[#0E1925] dark:border-white text-[#0E1925] dark:text-white font-bold z-10"
      else
        "#{base_classes} border-transparent text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200 font-medium"
      end
    end
end
