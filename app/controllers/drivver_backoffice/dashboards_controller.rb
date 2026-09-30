module DrivverBackoffice
    class DashboardsController < BaseController
      def show
        authorize [ :drivver_backoffice, :dashboard ]

        # --- 1. MÉTRICAS DE TARJETAS (Globales) ---
        @total_users = User.count
        @active_users = User.where(active: true).count
        @subscribed_users = User.joins(:subscriptions).where(subscriptions: { status: "active" }).distinct.count

        @total_organizations = Organization.count
        @active_orgs = Organization.joins(:subscriptions).where(subscriptions: { status: "active" }).distinct.count

        @total_vehicles = Vehicle.count

        @total_deals = Deal.count
        @sales_deals = Deal.where(deal_type: "sale").count
        @purchase_deals = Deal.where(deal_type: "purchase").count

        @total_events = Event.count

        @total_subscriptions = Subscription.count
        @active_subscriptions = Subscription.where(status: "active").count
        @inactive_subscriptions = Subscription.where(status: %w[inactive canceled past_due]).count

        # --- 2. LÓGICA DE FILTROS DINÁMICOS PARA GRÁFICAS ---
        @range_value = (params[:range_value] || 30).to_i
        @range_unit = params[:range_unit] || "days"

        # Calcular la fecha de inicio según el filtro seleccionado
        start_date = case @range_unit
        when "days"     then @range_value.days.ago.beginning_of_day
        when "weeks"    then @range_value.weeks.ago.beginning_of_week
        when "months"   then @range_value.months.ago.beginning_of_month
        when "quarters" then (@range_value * 3).months.ago.beginning_of_quarter
        when "years"    then @range_value.years.ago.beginning_of_year
        else 30.days.ago.beginning_of_day
        end

        # Serie acumulada: el total existente en cada periodo, no solo los registros nuevos.
        @users_growth    = build_growth_series(User, start_date, @range_unit)
        @orgs_growth     = build_growth_series(Organization, start_date, @range_unit)
        @vehicles_growth = build_growth_series(Vehicle, start_date, @range_unit)

        @deals_growth = [
          { name: "Ventas", data: build_chart_data(Deal.where(deal_type: "sale"), start_date, @range_unit) },
          { name: "Compras", data: build_chart_data(Deal.where(deal_type: "purchase"), start_date, @range_unit) },
          { name: "Activos", data: build_chart_data(Deal.where(status: "active"), start_date, @range_unit) },
          { name: "Terminados", data: build_chart_data(Deal.where(status: "finished"), start_date, @range_unit) }
        ]
      end

      private

      # Total acumulado hasta cada periodo del rango, incluyendo lo que ya existía antes.
      def build_growth_series(scope, start_date, unit)
        running = scope.where(created_at: ...start_date).count

        build_chart_data(scope, start_date, unit).transform_values do |count|
          running += count
        end
      end

      # Nuevos registros por periodo, con todos los periodos del filtro aunque el conteo sea cero.
      def build_chart_data(scope, start_date, unit)
        query = scope.where(created_at: start_date..Time.current)
        locale = :es
        range = start_date..Time.current

        case unit
        when "days"
          query.group_by_day(:created_at, range: range, series: true, format: "%-d %b %Y", locale: locale).count
        when "weeks"
          query.group_by_week(:created_at, range: range, series: true, format: "Sem %-W %Y", locale: locale).count
        when "months"
          query.group_by_month(:created_at, range: range, series: true, format: "%B %Y", locale: locale).count
        when "quarters"
          query.group_by_quarter(:created_at, range: range, series: true, format: ->(date) { "T#{((date.month - 1) / 3) + 1} #{date.year}" }).count
        when "years"
          query.group_by_year(:created_at, range: range, series: true, format: "%Y", locale: locale).count
        else
          query.group_by_day(:created_at, range: range, series: true, format: "%-d %b %Y", locale: locale).count
        end
      end
    end
end
