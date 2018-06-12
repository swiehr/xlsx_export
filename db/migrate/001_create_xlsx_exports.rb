class CreateXlsxExports < ActiveRecord::Migration
  def change
    create_table :xlsx_exports do |t|
      t.string :name
      t.text :description
      t.integer :some_number
      t.boolean :some_flag, default: false
      t.integer :author_id
      t.datetime :created_on
      t.datetime :updated_on
    end
  end
end
