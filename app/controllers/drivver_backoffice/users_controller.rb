module DrivverBackoffice
    class UsersController < BaseController
      def index
        authorize [ :drivver_backoffice, :user ]
        @pagy, @users = pagy(:offset, User.order(created_at: :desc), limit: 25)
      end

      def show
        # Eager loading para evitar N+1 queries en la vista
        @user = User.includes(
          :subscriptions,
          { families: :users },
          :vehicles,
          :deals,
          { organization_roles: :organization }
        ).find(params[:id])
        authorize [ :drivver_backoffice, @user ]

        @active_subscription = @user.subscriptions.find { |s| s.status == "active" }
        @active_deals = @user.deals.select { |d| d.status == "active" }
        @past_deals = @user.deals.reject { |d| d.status == "active" }

        @user_vehicles = @user.vehicles
        # Vehículos de la familia excluyendo los que ya están a nombre del usuario
        @family_vehicles = @user.families.flat_map(&:vehicles).uniq - @user_vehicles

        # Eventos activos de los vehículos del usuario
        @active_events = Event.includes(:organization, :vehicle).where(vehicle_id: @user_vehicles.pluck(:id), status: "active")
      end

      def toggle_active
        @user = User.find(params[:id])
        authorize [ :drivver_backoffice, @user ], :toggle_active?

        # Alterna el estado de true a false o viceversa
        @user.update(active: !@user.active)

        estado = @user.active? ? "reactivada" : "desactivada"
        flash[:notice] = "La cuenta del usuario ha sido #{estado} exitosamente."

        redirect_to drivver_backoffice_user_path(@user)
      end
    end
end
