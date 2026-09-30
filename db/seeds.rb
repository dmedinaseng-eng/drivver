require 'faker'
require 'open-uri'

puts "🧹 Limpiando la base de datos..."
# El orden de borrado importa por las llaves foráneas
Offer.destroy_all
Deal.destroy_all
EventRequirement.destroy_all
Event.destroy_all
Vehicle.destroy_all
FamilyMember.destroy_all
Family.destroy_all
OrganizationRole.destroy_all
Organization.destroy_all
User.destroy_all

puts "👤 Creando el usuario Super Admin..."
super_admin = User.create!(
  first_name: "David",
  last_name: "Drivver",
  email: "david@drivver.co",
  password: "password123",
  password_confirmation: "password123",
  global_role: :super_admin,
  active: true,
  id_type: "CC",
  id_number: "1000000001",
  phone_country_code: "CO",
  phone_number: "3000000001",
  city: "Bogotá",
  theme: "dark"
)

puts "👨‍👩‍👧‍👦 Creando Familia y Miembros..."
family = Family.create!(name: "meds")
FamilyMember.create!(family: family, user: super_admin, role: "admin", status: "active")

# Crear 2 miembros adicionales para la familia
member_1 = User.create!(
  first_name: "cata", last_name: "med", email: "cata@drivver.co", password: "password123",
  active: true, id_type: "CC", id_number: "1000000002", phone_country_code: "CO", phone_number: "3000000002", city: "Bogotá"
)
FamilyMember.create!(family: family, user: member_1, role: "member", status: "active")

member_2 = User.create!(
  first_name: "toms", last_name: "med", email: "toms@drivver.co", password: "password123",
  active: true, id_type: "CC", id_number: "1000000003", phone_country_code: "CO", phone_number: "3000000003", city: "Bogotá"
)
FamilyMember.create!(family: family, user: member_2, role: "member", status: "active")


puts "🚗 Creando Vehículos (Familia Drivver)..."
# Vehículos del Super Admin
car_sa = Vehicle.create!(
  user: super_admin, family: family, plate: "DRV123", brand: "Toyota", model: "Prado",
  year: "2023", color: "Blanco", vehicle_type: "Camioneta", chasis_id: "CH-SA-001", motor_id: "MT-SA-001"
)

moto_sa = Vehicle.create!(
  user: super_admin, family: family, plate: "MTO45C", brand: "BMW", model: "R1250GS",
  year: "2022", color: "Negro", vehicle_type: "Motocicleta", chasis_id: "CH-SA-002", motor_id: "MT-SA-002"
)

puts "🖼️ Descargando y adjuntando imágenes de prueba (Active Storage)..."
begin
  # Imagen genérica para el carro
  car_img = URI.open("https://placehold.co/800x600/1C5686/FFF.jpg?text=Carro+Toyota+Prado")
  car_sa.images.attach(io: car_img, filename: "carro_admin.jpg", content_type: "image/jpeg")

  # Imagen genérica para la moto
  moto_img = URI.open("https://placehold.co/800x600/EF4444/FFF.jpg?text=Moto+BMW+GS")
  moto_sa.images.attach(io: moto_img, filename: "moto_admin.jpg", content_type: "image/jpeg")
  puts "  ✅ Imágenes adjuntadas correctamente."
rescue => e
  puts "  ⚠️ Error al descargar imágenes: #{e.message}"
end

# Vehículos de la Familia
car_m1 = Vehicle.create!(
  user: member_1, family: family, plate: "FAM001", brand: "Mazda", model: "CX-5",
  year: "2021", color: "Rojo", vehicle_type: "Camioneta", chasis_id: "CH-M1-001", motor_id: "MT-M1-001"
)
car_m2 = Vehicle.create!(
  user: member_2, family: family, plate: "FAM002", brand: "Volkswagen", model: "Golf",
  year: "2019", color: "Gris", vehicle_type: "Automóvil", chasis_id: "CH-M2-001", motor_id: "MT-M2-001"
)

puts "🏢 Creando Organizaciones..."
org_trade   = Organization.create!(name: "Drivver Trade", org_type: "dealership", tax_id: "900111111", email: "trade@drivver.com", phone_country_code: "CO", phone_number: "3101111111")
org_shop    = Organization.create!(name: "Drivver Shop", org_type: "workshop", tax_id: "900222222", email: "shop@drivver.com", phone_country_code: "CO", phone_number: "3102222222")
org_pimp    = Organization.create!(name: "Drivver Pimp", org_type: "detailer_shop", tax_id: "900333333", email: "pimp@drivver.com", phone_country_code: "CO", phone_number: "3103333333")
org_talk    = Organization.create!(name: "Drivver Talk", org_type: "marketing_agency", tax_id: "900444444", email: "talk@drivver.com", phone_country_code: "CO", phone_number: "3104444444")
ext_dealer  = Organization.create!(name: "AutoVentas Externo", org_type: "dealership", tax_id: "900555555", email: "ventas@externo.com", phone_country_code: "CO", phone_number: "3105555555")
ext_shop    = Organization.create!(name: "Taller Multimarca", org_type: "workshop", tax_id: "900666666", email: "taller@externo.com", phone_country_code: "CO", phone_number: "3106666666")


puts "🔑 Asignando Roles en Organizaciones..."
# Roles del Super Admin en las empresas Drivver
OrganizationRole.create!(organization: org_trade, user: super_admin, role_name: "CEO", permissions: { "all": true })
OrganizationRole.create!(organization: org_shop, user: super_admin, role_name: "Manager", permissions: { "manage_events": true })
OrganizationRole.create!(organization: org_pimp, user: super_admin, role_name: "admin", permissions: { "manage_events": true })
OrganizationRole.create!(organization: org_talk, user: super_admin, role_name: "staff", permissions: { "manage_campaigns": true })

puts "👤🚗🤝 Creando Empleados con sus Vehículos, Deals y Eventos..."
# Crear usuarios genéricos (empleados), y a cada uno asignarle un carro, un Deal y un Evento
1.upto(5) do |i|
  # 1. Crear el Empleado
  emp = User.create!(
    first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.unique.email, password: "password123",
    active: true, id_type: "CC", id_number: "200000000#{i}", phone_country_code: "CO", phone_number: "320000000#{i}", city: "Bogotá"
  )

  # 2. Asignarlo a las organizaciones
  if i <= 2
    OrganizationRole.create!(organization: org_trade, user: emp, role_name: "Sales Agent")
    OrganizationRole.create!(organization: ext_dealer, user: emp, role_name: "Sales Agent")
  else
    OrganizationRole.create!(organization: org_shop, user: emp, role_name: "Mechanic")
    OrganizationRole.create!(organization: ext_shop, user: emp, role_name: "Mechanic")
  end

  # 3. Darle un vehículo (Notamos que 'family' es opcional en el modelo actual)
  emp_car = Vehicle.create!(
    user: emp, plate: "EMP00#{i}", brand: "Ford", model: "Fiesta",
    year: "201#{i}", color: "Azul", vehicle_type: "Automóvil", chasis_id: "CH-EMP-#{i}", motor_id: "MT-EMP-#{i}"
  )

  # 4. Crear un Deal para ese vehículo (Ej. org_trade le está comprando el carro al empleado)
  Deal.create!(
    organization: org_trade, vehicle: emp_car, client: emp,
    deal_type: "purchase", status: "open"
  )

  # 5. Crear un Evento para ese vehículo (Ej. Mantenimiento en org_shop)
  Event.create!(
    organization: org_shop, vehicle: emp_car, user: emp,
    event_type: "maintenance", status: "open", custody_flag: false, price_cents: 95000
  )
end

puts "🤝 Creando Negocios y Eventos para el Super Admin y Familia..."

# Venta (El super_admin vende su moto a ext_dealer)
Deal.create!(
  organization: ext_dealer, vehicle: moto_sa, client: super_admin,
  agent_seller_id: super_admin.id, deal_type: "sale", status: "open"
)

# Negocios de la familia
Deal.create!(
  organization: org_trade, vehicle: car_m1, client: member_1,
  deal_type: "sale", status: "pending"
)
Deal.create!(
  organization: org_trade, vehicle: car_m2, client: member_2,
  deal_type: "purchase", status: "open"
)

# Eventos en Drivver Shop y Drivver Pimp
Event.create!(
  organization: org_shop, vehicle: car_sa, user: super_admin,
  event_type: "maintenance", status: "in_progress", custody_flag: true, price_cents: 250000
)
Event.create!(
  organization: org_pimp, vehicle: moto_sa, user: super_admin,
  event_type: "detailing", status: "completed", custody_flag: false, price_cents: 80000
)

# Eventos en organizaciones externas y para otros usuarios
Event.create!(
  organization: ext_shop, vehicle: car_m1, user: member_1,
  event_type: "maintenance", status: "open", custody_flag: true, price_cents: 120000
)
Event.create!(
  organization: org_shop, vehicle: car_m2, user: member_2,
  event_type: "repair", status: "open", custody_flag: false, price_cents: 500000
)

puts "✅ ¡Base de datos poblada exitosamente con el escenario completo!"
