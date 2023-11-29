class CreateStyles < ActiveRecord::Migration[7.0]
  def self.up
    create_table :styles do |t|
      t.index :id
      t.text :name
      t.text :description

      t.timestamps
    end

    change_table :beers do |t|
      t.rename :style, :old_style
      t.references :style
    end

    Beer.all.each do |beer|
      style = Style.find_by name: beer.old_style
      if style.nil?
        Style.create name: beer.old_style
      end
    end

    Beer.all.each do |beer|
      style = Style.find_by name: beer.old_style

      if style.nil?
        Beer.update beer.id, { :style_id => 1 }
      else
        Beer.update beer.id, { :style_id => style.id }
      end
    end

    remove_column :beers, :old_style
  end

  def self.down
    add_column :beers, :style_name, :text

    Beer.all.each do |beer|
      style = Style.find_by id: beer.style_id
      if style.nil?
        Beer.update beer.id, { :style_name => "IPA" }
      else
        Beer.update beer.id, { :style_name => style.name }
      end
    end

    remove_column :beers, :style_id
    rename_column :beers, :style_name, :style
    drop_table :styles
  end
end
