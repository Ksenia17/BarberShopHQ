class CreateClients < ActiveRecord::Migration[5.1]
  def change

  	create_table :clients do |t|
  		t.text :name
  		t.text :phone
  		t.text :datestamp
  		t.text :barber
  		t.text :color

  		t.timestamps	
  	end	

    Client.create :name =>'Client 1'
    Client.create :name =>'Client 2'
    Client.create :name =>'Client 3'

  end
end
