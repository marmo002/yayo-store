# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development?

  %w(zapatillas zapatos sandalias polo billeteras gorras pantalones).each { |type|
    Type.create(name: type)
  }

  %w(lacoste adidas nike rebook vans).each { |brand|
    Brand.create(name: brand)
  }

  [
    ["rojo", "#b7011c"], ["blanco", "#ffffff"],
    ["negro", "#000000"], ["amarillo", "#fafd49"],
    ["verde", "#19e1af"], ["azul", "#0059ff"]
  ].each do |color|
    Color.create(name: color[0], hex: color[1])
  end

  %w(35 35.5 36.5 37 37.5 38 38.5 39 39.5 40 40.5 41 41.5 42 42.5 43 43.5 44)
  .each do |size|
    Size.create(name: size)
  end

end
