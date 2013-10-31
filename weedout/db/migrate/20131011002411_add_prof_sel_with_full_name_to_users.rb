class AddProfSelWithFullNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string
    add_column :users, :signup_as_professor, :boolean
  end
end
