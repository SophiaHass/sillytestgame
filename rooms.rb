#preparing stuff

class Room
  attr_accessor :menu1, :menu2, :menu3, :output1, :output2, :output3, :action1, :action2, :action3, :text
end 

room1 = Room.new
room2 = Room.new
room3 = Room.new
room4 = Room.new
room5 = Room.new

inventory = []
currentroom = room1


#room content

#room1
room1.text = "You are in a room with a clown statue. Do you want to take the door to the left, the door to the right, or pick up a sword?"
room1.menu1 = "Go left"
room1.menu2 = "Go right"
room1.menu3 = "Pick up a sword"
room1.output1 = room2
room1.output2 = room3
room1.output3 = room1 
pickup = Proc.new do
  puts "You have the sword. Type \"i\" into the console at any time to see the inventory."
  room1.text = "You are in a room with a clown statue. Do you want to take the door to the left or the door to the right?"
  room1.menu3 = nil
  inventory << "Sword"
  end
room1.action3 = pickup

#room2
room2.text = "Here's another room. Where?"
room2.menu1 = "Go up"
room2.menu2 = "Go down"
room2.output1 = room3
room2.output2 = room3

#room3
room3.text = "You're in a room. There's an apple here. Do you eat it?"

appleeat = Proc.new do 
  puts "You ate the apple."
  room3.text = "There is nothing here now."
  room3.menu1 = "Do something else"
  room3.output1 = room1 
end

appledont = Proc.new do
  puts "You put the apple in a cupboard, to avoid temptation."
  room3.text = "There is nothing here now."
end

room3.menu1 = "Yes" 
room3.action1 = appleeat 
room3.menu2 = "No"
room3.action2 = appledont
room3.output1 = room3
room3.output2 = room3

#room4
room4.text = "You're in a room"

#room5
room5.text = "You're in a room"



#begin
puts "Welcome to Silly Test Game! In this game there are no winners, only bugs."

loop do

  #prepare variables
  output1 = currentroom.output1 
  output2 = currentroom.output2 
  output3 = currentroom.output3 
  action1 = currentroom.action1 if currentroom.action1
  action2 = currentroom.action2 if currentroom.action2
  action3 = currentroom.action3 if currentroom.action3

  #print text
  puts currentroom.text

  puts "1. #{currentroom.menu1}" if currentroom.menu1
  puts "2. #{currentroom.menu2}" if currentroom.menu2
  puts "3. #{currentroom.menu3}" if currentroom.menu3

  #input and processing
  input = gets.chomp

    case input.downcase 
    when "1"
      currentroom.menu1
      action1.call if currentroom.action1 
      currentroom = output1 
    when "2"
      currentroom.menu2
      action2.call if currentroom.action2
    currentroom = output2
    when "3"
      currentroom.menu3
      action3.call if currentroom.action3
      currentroom = output3  
    when "i" 
      if inventory.empty?
        puts "You look in your backpack. There is a mummified apple core inside. Not daring to touch it directly, you tip it out."
      else
        puts "Inventory contents:", inventory
      end
    when "q"
      break
    else puts "error" 
    end

end