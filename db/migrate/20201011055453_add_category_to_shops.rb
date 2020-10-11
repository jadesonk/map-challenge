class AddCategoryToShops < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE shop_category AS ENUM ('not_set', 'spa_and_massage', 'nails', 'hair_removal', 'barbershop');
    SQL
    add_column :shops, :category, :shop_category
  end

  def down
    remove_column :catalogs, :category
    execute <<-SQL
      DROP TYPE shop_category;
    SQL
  end
end
