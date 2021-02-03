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
          attachments.blob_id as blob,
          SUM(color_sizes.stock) as stock
        FROM products
        INNER JOIN types
          ON products.type_id = types.id
        INNER JOIN brands
          ON products.brand_id = brands.id
        LEFT JOIN product_colors
          ON products.id = product_colors.product_id
        LEFT JOIN color_sizes
          ON product_colors.id = color_sizes.product_color_id
        left join (
            SELECT
            p_color.id as product_color_id,
            min(sb.id) as blob_id
            FROM product_colors p_color
            INNER JOIN active_storage_attachments sa
            ON p_color.id = sa.record_id
            INNER JOIN active_storage_blobs sb
            ON sa.blob_id = sb.id
            GROUP BY product_color_id
          ) as attachments
          ON product_colors.id = attachments.product_color_id
        WHERE status = 1
        GROUP BY
          products.id,
          category,
          marca,
          products.title,
          products.price,
          products.sale_price,
          attachments.blob_id
        HAVING SUM(color_sizes.stock) > 0
        ORDER BY products.updated_at desc"
    )

  end

  private

end
