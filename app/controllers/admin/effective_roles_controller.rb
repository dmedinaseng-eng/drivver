class Admin::EffectiveRolesController < Os::BaseController
    def create
        # Pundit valida que solo el equipo interno pueda ejecutar esta acción
        authorize :effective_role, :create?
  
        if params[:target_role] == "admin"
          current_user.update_column(:current_context, "admin")
          flash[:notice] = "Entorno Operativo (Admin Mode) activado. La interfaz ha sido resaltada en rojo por seguridad."
        else
          current_user.update_column(:current_context, "personal")
          flash[:notice] = "Modo Usuario Estándar activado. Estás gestionando tu propio garaje."
        end
  
        redirect_to os_settings_path
      end
end
