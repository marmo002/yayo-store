module ProductsHelper
    def number_to_soles(number_to_soles)
        number_to_currency(number_to_soles, unit: 'S/.')
    end

    def product_title(product)
        product.title.empty? ? "#{product.category} #{product.marca}" : product.title
    end
end
