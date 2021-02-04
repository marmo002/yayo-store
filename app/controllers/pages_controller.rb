class PagesController < ApplicationController

  def home

  end

  def shop
    @categories = Type.pluck(:name).sort
    @brands = Brand.pluck(:name).sort

    @products = Product.find_by_sql(
      "SELECT
        products.id as id,
        products.title,
        products.price,
        products.sale_price,
        types.name as category,
        brands.name as marca,
        SUM(color_sizes.stock) as stock,
        attachments.blob_id as blob
      FROM products
      INNER JOIN types
        ON products.type_id = types.id
      INNER JOIN brands
        ON products.brand_id = brands.id
      inner JOIN product_colors
        ON products.id = product_colors.product_id
      inner JOIN color_sizes
        ON product_colors.id = color_sizes.product_color_id
      inner join (
        select
          p_color.product_id as product_id,
          min(p_color.id) as product_color_id,
          min(sb.id) as blob_id
        FROM product_colors p_color
        INNER JOIN active_storage_attachments sa
          ON p_color.id = sa.record_id
        INNER JOIN active_storage_blobs sb
          ON sa.blob_id = sb.id
        WHERE sa.record_type = 'ProductColor'
        GROUP by
          p_color.product_id
        ) as attachments
        ON products.id = attachments.product_id
      WHERE status = 1
      GROUP BY
        products.id,
        products.title,
        products.price,
        products.sale_price,
        category,
        marca,
        attachments.blob_id
      HAVING SUM(color_sizes.stock) > 0
      ORDER BY products.updated_at desc"
    )

  end

  private

end
