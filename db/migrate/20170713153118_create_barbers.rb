class CreateBarbers < ActiveRecord::Migration[5.1]
  def change
  	create_table :barbers do |t|
  		t.text :name
  		
  		t.timestamps	
  	end	
  	Barber.create :name =>'Name 1'
  	Barber.create :name =>'Name 2'
  	Barber.create :name =>'Name 3'
  end
end
