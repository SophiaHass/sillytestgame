

@pickup = Proc.new do
  print "\nYou have the sword."
  @inventorynote.call
  print "\n\n"
  @clownroom.text = "You are in a room with a clown statue. Do you want to take the door to the east or the door to the west?\n\n"
  @clownroom.menu3 = nil
  @inventory << "Sword"
  end
