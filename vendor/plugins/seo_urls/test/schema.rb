ActiveRecord::Schema.define(:version => 0) do
  create_table :posts, :force => true do |t|
    t.column :title, :string
  end
  
  create_table :people, :force => true do |t|
    t.column :name, :string
  end
  
  create_table :animals, :force => true do |t|
    t.column :common_name, :string
  end
end