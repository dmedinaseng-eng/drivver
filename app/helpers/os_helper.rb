module OsHelper
  # Diccionario central de diseño por vertical operativa (Sistema 1 neurocognitivo)
  CONTEXT_UI = {
    "personal"         => { emoji: "👤", color: "#0033CC" },
    "drivver_backoffice"            => { emoji: "🚨", color: "#EF4444" },
    "dealership"       => { emoji: "🏢", color: "#2D9BD2" },
    "workshop"         => { emoji: "🔧", color: "#8A2BE2" },
    "detailer_shop"    => { emoji: "✨", color: "#8B008B" }
  }.freeze

  def current_context_ui
    path = request.path
    
    if path.start_with?('/drivver_backoffice')
      build_context_hash("drivver_backoffice", "Drivver Backoffice", "drivver_backoffice", drivver_backoffice_root_path)
    elsif path.start_with?('/os/dealership')
      build_context_hash("dealership", "Concesionario", "dealership", os_dealership_root_path)
    elsif path.start_with?('/os/workshop')
      build_context_hash("workshop", "Taller", "workshop", os_workshop_root_path)
    elsif path.start_with?('/os/detailer')
      build_context_hash("detailer", "Detailing", "detailer_shop", os_detailer_root_path)
    else
      personal_name = current_user.full_name.presence || current_user.email.split("@").first
      build_context_hash("personal", personal_name, "personal", os_root_path)
    end
  end

  def available_contexts_ui
    personal_name = current_user.full_name.presence || current_user.email.split("@").first
    list = [ build_context_hash("personal", personal_name, "personal", os_root_path) ]

    if current_user.internal_team?
      list << build_context_hash("drivver_backoffice", "Drivver Backoffice", "drivver_backoffice", drivver_backoffice_root_path)
    end

    current_user.organizations.each do |org|
      url = case org.org_type
            when "dealership"    then os_dealership_root_path
            when "workshop"      then os_workshop_root_path
            when "detailer_shop" then os_detailer_root_path
            else os_root_path
            end
      
      list << build_context_hash(org.id, org.name, org.org_type, url)
    end
    
    list
  end

  def os_navigation_items
    menu = {
      main: [],   # Inicio + Módulos operativos
      system: []  # Admin + Configuración
    }

    # 1. Inicio (Siempre presente, siempre el primero)
    menu[:main] << {
      title: "Inicio", short_title: "Inicio", path: os_root_path,
      icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>'
    }

    # 2. Módulos Operativos Dinámicos
    if current_user.operating_in_dealership? || current_user.operating_in_admin_context?
      menu[:main] << {
        title: "Negocios y Venta", short_title: "Negocios", path: "#deal", icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>'
      }
    end

    if current_user.operating_in_workshop? || current_user.operating_in_admin_context?
      menu[:main] << {
        title: "Órdenes Trabajo", short_title: "Órdenes", path: "#work", icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 4a2 2 0 114 0v1a2 2 0 01-2 2 2 2 0 01-2-2V4zm-6 8a2 2 0 100-4 2 2 0 000 4zm12 0a2 2 0 100-4 2 2 0 000 4zm-6 0a2 2 0 100-4 2 2 0 000 4z"/>'
      }
    end

    if current_user.operating_in_detailer? || current_user.operating_in_admin_context?
      menu[:main] << {
        title: "Servicios Detailing", short_title: "Detailing", path: "#det", icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"/>'
      }
    end

    if current_user.operating_in_personal_context?
      menu[:main] << {
        title: "Mi Garaje", short_title: "Mi Garaje", path: "#garage", icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"/>'
      }
    end

    # 3. Menús del Sistema
    if operating_as_internal_team?
      menu[:system] << {
        title: "Usuarios Globales", short_title: "Usuarios", path: "#users", icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>', is_danger: true
      }
    end

    menu[:system] << {
      title: "Configuración", short_title: "Ajustes", path: os_settings_path, icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>'
    }

    menu
  end

  def mobile_navigation_structure
    # Aplanamos todos los ítems en una sola lista
    all_items = os_navigation_items[:main] + os_navigation_items[:system]

    {
      home: all_items.shift,        # Extrae el primero (Inicio)
      visible: all_items.take(2),   # Toma los 2 siguientes para la barra
      overflow: all_items.drop(2)   # El resto al menú de desbordamiento (Más)
    }
  end

  private

  def build_context_hash(id, name, type, url)
    ui = CONTEXT_UI[type] || CONTEXT_UI["personal"]
    { id: id, name: name, emoji: ui[:emoji], color: ui[:color], url: url }
  end

  def build_nav_item(title, short_title, path, icon_path_d, is_danger = false)
    { title: title, short_title: short_title, path: path, is_danger: is_danger, 
      icon: "<path stroke-linecap=\"round\" stroke-linejoin=\"round\" stroke-width=\"2\" d=\"#{icon_path_d}\"/>" }
  end
end
