ActiveRecord::Schema.define(:version => 0) do
  create_table :people, :force => true do |t|
    t.string :email
  end

  create_table :mx_records, :force => true do |t|
    t.string :email
  end

  create_table :mx_fallbacks, :force => true do |t|
    t.string :email
  end
end