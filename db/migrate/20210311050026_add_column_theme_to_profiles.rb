class AddColumnThemeToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :theme, :integer, default: 0 # enum
  end
end
