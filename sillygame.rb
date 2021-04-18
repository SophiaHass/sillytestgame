#to share this with people who don't know command line I can send them to: https://www.onlinegdb.com/online_ruby_compiler

require "./pickup"

#preparing stuff

class Room
  attr_accessor :menu1, :menu2, :menu3, :menu4, :output1, :output2, :output3, :output4, :action1, :action2, :action3, :action4, :text
end 

#rooms
@clownroom = Room.new
@hubroom = Room.new
@appleroom = Room.new
@northroom = Room.new
@southroom = Room.new
@stairsroom = Room.new
@uproom = Room.new
@downroom = Room.new
@watermelonroom = Room.new

#conditions that can change
@applecore = true
@forced = false
@newtonnote = false
@corpse = false

#other stuff
@inventory = []
currentroom = @clownroom


#room content

#@clownroom
@clownroom.text = "\nYou are in a room with a clown statue and a sword lying on the ground. Do you want to take the door to the east, the door to the west, or pick up the sword?\n\n"
@clownroom.menu1 = "East"
@clownroom.menu2 = "West"
@clownroom.menu3 = "Pick up the sword"
@clownroom.output1 = @hubroom
@clownroom.output2 = @appleroom
@clownroom.output3 = @clownroom 

@hashy = {t: "\nYou are in a room with a clown statue and a sword lying on the ground. Do you want to take the door to the east, the door to the west, or pick up the sword?\n\n", m: ["East", "West", "Pick up the sword"], o: [@hubroom, @appleroom, @clownroom], a: @pickup}

  #object class: sword, apple... pickup method, use method

@messagesent = false
@inventorynote = Proc.new do
  if @inventory.empty? && @messagesent == false
    print " Type 'i' into the console at any time to see the inventory." 
  end
  @messagesent = true
end


@clownroom.action3 = @pickup

#hubroom
@hubroom.text = "\nYou are in a room with four doors. Do you want to go to the room with the clown statue, or take the door to the east, north, or south?\n\n"
@hubroom.menu1 = "Take the east door"
@hubroom.menu2 = "Take the north door"
@hubroom.menu3 = "Take the south door"
@hubroom.menu4 = "Go to the clown room"
@hubroom.output1 = @hubroom
@hubroom.output2 = @northroom
@hubroom.output3 = @southroom
@hubroom.output4 = @clownroom

@pikalock = Proc.new do
  puts "\nYou examine the lock a little closer. 

That's it! Now that you think about it, your pika is a TIBETAN pika, not an American one!

You put your Tibetan pika in the Tibetan-pika shaped lock, and turn.

The door swings open with a satisfying *click*. You give your pika a high five.\n"
@inventory.delete "Pika (presumed American)"
@inventory << "Tibetan pika"
@hubroom.text = "\nYou are in a room with four doors. The door to the east is finally open.\n\n"
@hubroom.menu1 = "Take the east door"
@hubroom.output1 = @watermelonroom
@hubroom.action1 = nil
end

@forcelock = Proc.new do
  if @inventory.include? "Sword"
    puts "\nYou draw your sword, narrow your eyes, and concentrate. You stare deep into the Tibetan pika shaped keyhole. Your muscles tense... 
...
...
...
...Eh, better not.\n"
  else puts "\nYou kick the door. It hurts.\n"
    @forced = true
  end
  if @inventory.include? "Pika (presumed American)"
    @hubroom.text = "\nYou are in a room with four doors. You have the impulse to examine the lock on the east door a little closer.\n\n"
    @hubroom.menu1 = "Examine the east door lock more closely"
    @hubroom.action1 = @pikalock
  end
  

end

@nokey = Proc.new do
  puts "\nThis door has a lock on it, and doesn't budge when you turn the handle. The keyhole is shaped like a Tibetan pika.\n\n"
  @hubroom.text = "\nYou are in a room with four doors. Do you want to go back to the room with the clown statue, take the door to the north or south, or try to force the lock on the east door?\n\n"
  @hubroom.menu1 = "Force the east door"
  @hubroom.action1 = @forcelock
end

@hubroom.action1 = @nokey

#northroom
@knock = Proc.new do
  if @inventory.include? "Sword"
    puts "\nYou slice the pancakes into pieces with your sword! You look extremely cool.\n"
  else puts "\nYou push the stack over.\n"
  end
  print "\nThe pancakes collapse. You see a glint of something metallic fall and land on top of the delicious, messy pile. It turns out to be the broken half of a key. You put it in your backpack."
  @inventorynote.call
  @inventory << "Top half of a key"
  puts "\n"
  @northroom.text = "\nThis room contains a sticky, slimy pile of cold pancakes. They look like they have learnt their lesson.\n\n"
  @northroom.menu1 = "Go south"
  @northroom.menu2 = nil
  @northroom.output1 = @hubroom
  @northroom.action1 = nil
end

@suspicious = false
@dontknock = Proc.new do
  @suspicious = true
  @northroom.menu1 = "Go south"
  @northroom.menu2 = "Knock over the pancakes"
  @northroom.output1 = @hubroom 
  @northroom.output2 = @northroom
  @northroom.action1 = nil
  @northroom.action2 = @knock
end


@northroom.text = "\nThis room contains a suspicious-looking stack of pancakes, reaching almost to the ceiling.\n\n"
@northroom.menu1 = "Knock down the pancakes"
@northroom.menu2 = "Trust the pancakes, like a fool, and don't knock them down"
@northroom.action1 = @knock
@northroom.action2 = @dontknock
@northroom.output1 = @northroom
@northroom.output2 = @northroom

#southroom

@loot = Proc.new do 
print "\nIn the chest you find one half of a broken key. You put it in your backpack."
@inventorynote.call
puts "\n"
@inventory << "Bottom half of a key"
@southroom.text = "\nThis room contains a looted, medieval-style wooden chest with a note on it saying 'definitely not relevant to the plot'.\n\n"
@southroom.menu1 = "Go north"
@southroom.menu2 = nil
@southroom.action1 = nil
@southroom.output1 = @hubroom
@southroom.output2 = nil
end

@southroom.text = "\nThis room contains a medieval-style wooden chest with a note on it saying 'definitely not relevant to the plot'.\n\n"
@southroom.menu1 = "Loot the chest"
@southroom.menu2 = "Go north"
@southroom.action1 = @loot
@southroom.output1 = @southroom 
@southroom.output2 = @hubroom

#appleroom
@appleroom.text = "\nYou're in a room. There's an apple here. Do you eat it?\n\n"

@appleeat = Proc.new do 
  puts "\nYou ate the apple. Nothing peculiar happens.\n"
  @appleroom.text = "\nYou're in a room with a conspicuous absence of apple. Do you want to go east, back to the clown statue room, or west?\n\n"
  @appleroom.menu1 = "Go back to the clown statue room"
  @appleroom.output1 = @clownroom 
  @appleroom.menu2 = "Go west"
  @appleroom.output2 = @stairsroom 
  @appleroom.action1 = nil
  @appleroom.action2 = nil
end

@appledont = Proc.new do
  puts "\nYou put the apple in a cupboard, to avoid temptation.\n"
  @appleroom.text = "\nYou're in a room with a conspicuous absence of apple. Do you want to go east back to the clown statue room, or west?\n\n"
  @appleroom.menu1 = "Go back to the clown statue room"
  @appleroom.output1 = @clownroom 
  @appleroom.menu2 = "Go west"
  @appleroom.output2 = @stairsroom 
  @appleroom.action1 = nil
  @appleroom.action2 = nil
end

@appleroom.menu1 = "Yes" 
@appleroom.menu2 = "No"
@appleroom.action1 = @appleeat 
@appleroom.action2 = @appledont
@appleroom.output1 = @appleroom
@appleroom.output2 = @appleroom

#stairsroom
@stairsroom.text = "\nYou find yourself in a room with a spiral staircase going up and down. A person stands in front of you, looking uncannily similar to you in every way except that they have purple skin. They speak:

'I don't have much time so I will have to be quick. I am you, from the future. I came to tell you something important, something that will have grave consequences for your quest to escape this silly game.'\n\n"
@stairsroom.menu1 = "Fight your future self"
@stairsroom.menu2 = "Seduce your future self"
@stairsroom.menu3 = "Listen to your future self"

@newtonnoter = Proc.new do
  @newtonnote = true
end

@newmenu = Proc.new do
  @stairsroom.menu1 = "Go up"
  @stairsroom.menu2 = "Go down"
  @stairsroom.menu3 = "Go east"
  @stairsroom.action1 = @newtonnoter
  @stairsroom.action2 = nil
  @stairsroom.action3 = nil
  @stairsroom.output1 = @uproom
  @stairsroom.output2 = @downroom
  @stairsroom.output3 = @appleroom
  @stairsroom.text = "\nYou're in a room with a spiral staircase going up and down. There's a door to the east.\n\n"
end

@fight = Proc.new do
  if @inventory.include? "Sword"
    puts "\nYou draw your sword and cut off your future head from your future body. The sword snaps in half! You toss the broken sword away. Something tells you this was a bad idea.\n"
    @inventory.delete("Sword")
    @corpse = true
  else
    puts "\nYou pummel your future self ineffectually. After a brief scuffle a time portal opens up and your future self disappears into it, leaving you with nothing but bruised fists and a feeling of foolishness.\n"
  end
  @newmenu.call 
  @stairsroom.text = "\nYou're in a room with a spiral staircase, a broken sword and a corpse. There's a door to the east.\n\n" if @corpse 
end

@fuck = Proc.new do
  puts "\nYou hold up your finger and press it against your future self's lips in a sexy 'hush' gesture. You begin to make out passionately. Suddenly a time portal opens up and your future self disappears into it, leaving you with nothing but a sense of frustrated desire. \n"
  @newmenu.call
end

@listen = Proc.new do
  puts "\n'I'm listening,' you say.

'Good,' says your future self. 'Honestly, I'm relieved. I expected you to act much weirder right now. Now, listen: the American pika is actually a--'
  
Suddenly a time portal opens up and sucks your future self back to the future before they can say another word!\n"
  @newmenu.call
end

@stairsroom.action1 = @fight
@stairsroom.action2 = @fuck
@stairsroom.action3 = @listen
@stairsroom.output1 = @stairsroom
@stairsroom.output2 = @stairsroom
@stairsroom.output3 = @stairsroom


#uproom
@uproom.text = "\nAt the top of the spiral staircase is a weightless void. Albert Einstein sits at a parisian-style cafe table across from Isaac Newton, drinking tea from fine bone china. There's also a suit of +1 mithril chain mail.\n\n"
@uproom.menu1 = "Try to join the conversation"
@uproom.menu2 = "Don the armor"
@uproom.menu3 = "Go back down"

@uproom.output1 = @uproom
@uproom.output2 = @uproom
@uproom.output3 = @stairsroom

@don = Proc.new do
end

@convo = Proc.new do
  puts "\nYou sidle onto one of the chairs. Newton and Einstein go silent and watch you intently. 'So,' you say, facing Newton, 'Do you like apples?'

A long, awkward silence. You instead turn to Einstein, 'How are your relatives?'

'Excuse us, but we're having a PRIVATE conversation here!' snaps Newton.

'Yeesh, no need to get all equal and opposite,' you say, and get back up.\n"
  if @inventory.include? "+1 Mithril Armor" #I know some of the list items here are redundant, but it seems less confusing to me to have a complete list of all the menu items, actions and outputs.
    @uproom.menu1 = "Go back down" 
    @uproom.menu2 = nil
    @uproom.menu3 = nil  
    @uproom.action1 = nil
    @uproom.action2 = nil
    @uproom.output1 = @stairsroom
    @uproom.output2 = nil
    @uproom.output3 = nil
  else
    @uproom.menu1 = "Go back down"
    @uproom.menu2 = "Don the armor"
    @uproom.menu3 = nil  
    @uproom.action1 = nil
    @uproom.action2 = @don
    @uproom.output1 = @stairsroom
    @uproom.output2 = @uproom
    @uproom.output3 = nil
  end
end

@don = Proc.new do
  print "\nYou don the armor. You feel very prepared for anything that might happen from now on."
  @uproom.text = "\nAt the top of the spiral staircase is a weightless void. Albert Einstein sits at a parisian-style cafe table across from Isaac Newton, drinking tea from fine bone china.\n\n"
  @inventorynote.call
  print "\n"
  @inventory << "+1 Mithril Armor"

  if @uproom.menu1 == "Try to join the conversation"
    @uproom.menu1 = "Try to join the conversation"
    @uproom.menu2 = "Go back down"
    @uproom.menu3 = nil  
    @uproom.action1 = @convo
    @uproom.action2 = nil
    @uproom.output1 = @uproom
    @uproom.output2 = @stairsroom
    @uproom.output3 = nil
  else
    @uproom.menu1 = "Go back down"
    @uproom.menu2 = nil
    @uproom.menu3 = nil  
    @uproom.action1 = nil
    @uproom.action2 = nil
    @uproom.output1 = @stairsroom
    @uproom.output2 = nil
    @uproom.output3 = nil
  end
end

@uproom.action1 = @convo
@uproom.action2 = @don


#downroom
@downroom.text = "\nThis room is empty except for (approximately) #{rand(1001..9999)} losing lottery tickets, and an American pika making its nest among them. The pika looks friendly.\n\n"

@pika = Proc.new do
  
  @downroom.text = "\nThis room is empty except for (approximately) #{rand(1001..9999)} losing lottery tickets, with a pika-shaped depression in the middle of them.\n\n"
  puts "\nThe pika squeaks.\n"
  @inventory << "Pika (presumed American)"
  @inventorynote.call
  if @forced == true
    @hubroom.text = "\nYou are in a room with four doors. You have the impulse to examine the lock on the east door a little closer.\n\n"
    @hubroom.menu1 = "Examine the lock more closely"
    @hubroom.action1 = @pikalock
  end
  @downroom.menu1 = "Go back up"
  @downroom.menu2 = nil  
  @downroom.action1 = nil
  @downroom.output1 = @stairsroom

end


@downroom.menu1 = "Take the pika with you"
@downroom.menu2 = "Go back up"  
@downroom.action1 = @pika
@downroom.output1 = @downroom
@downroom.output2 = @stairsroom

#watermelonroom
@katanathing = false
@losecounter = 0
@makez = nil
@who = nil
@herWP = nil
@yourWP = nil
@slic = "smash"
@outcome = nil


@herround = Proc.new do

    #determines new WP and changes negative values to zero
    @hersmash = rand(5..20)
    @yourWP = @yourWP - @hersmash
    if @yourWP < 0
      @yourWP = 0
    end
  
    #katana flavor text, shows once 
    if @katanathing == false 
       puts "\nThe old lady pulls out her katana and slices watermelons with expert skill and extreme focus. She bows to her defeated foes before sheathing her sword again."
       @katanathing = true
    end 
   
    #output to console
    puts "\nThe old lady sliced #{@hersmash} watermelons!\n"
  
    #lose condition
    if @yourWP == 0
      @outcome = "You lose!"
      @losecounter +=1
    end
  
  end
  
  @yourround = Proc.new do
    
    #determines damage and adjusts text, depending on sword
    if @inventory.include? "Sword" 
      @smashy = rand(5..20) + 2 
      @slic = "slic"
    else
      @smashy = rand(0..15)
    end

    #determines new WP and changes negative values to zero
    @herWP = @herWP - @smashy
    if @herWP < 0
      @herWP = 0
    end
  
    #output to console
    puts "\nYou #{@slic}ed #{@smashy} watermelons!\n"
    if @herWP == 0
      @outcome = "You win!"
    end

  end
  
  @watermelonbattle = Proc.new do

  #initiating variables
  @yourWP = 50
  @herWP = 50
  @round = 1
  @youstart = nil
  @shestarts = nil
  @slic = "smash"
  @outcome = nil

  #hint for player about sword
  if @corpse == true && @losecounter == 0
    puts "\nThe watermelon battle begins. Your hand instinctively goes to your hip, before realising that you broke your sword. If only you still had it...\n\n"
  end 

  #initiative roll
  @herroll = rand(1..20) + 4
  @yourroll = rand(1..29) - 2

  if @yourroll > @herroll
    @youstart = true
    @who = "you"
    @makez = "make"
  else 
    @shestarts = true
    @who = "she"
    @makez = "makes"
  end

  puts "\nYou and the old lady stare each other down. After a brief, silent battle of wits, #{@who} #{@makez} the first move!\n"

  #round processor
  loop do 
    puts "\nRound ##{@round}. Press enter to #{@slic}#{"e" if @slic == "slic"} watermelons."
    @inputter = gets.chomp
    @round += 1

    if @inputter.downcase == "q"
      puts "\n\n\nEnter 'q' again to quit. Sorry, this is just for fiddly technical reasons. P.S. Do you really hate watermelons so much?"
      break
    end

    if @youstart
      @yourround.call
      @herround.call if @outcome == nil
    elsif @shestarts
      @herround.call
      @yourround.call if @outcome == nil
    end

    puts "\nYour WP: #{@yourWP}"
    puts "\nOld lady's WP: #{@herWP}"
    puts ""

    #the outcome
    break if @outcome == "You win!" || @outcome == "You lose!"
  end

  puts "", @outcome

  #hints about the sword
  puts "\nYou really wish you still had that sword...\n\n" if @corpse == true && @losecounter == 1 && @outcome == "You lose!"
  puts "\nYou REALLY wish you still had that sword...\n\n" if @corpse == true && @losecounter == 3
  puts "\nOh, what you would do to have that sword back which you broke...\n\n" if @corpse == true && @losecounter == 5
  puts "\nYou almost regret your actions which led to you breaking your sword. Almost.\n\n" if @corpse == true && @losecounter == 7
  puts "\nYou wish you had found some way of killing your future self which hadn't meant breaking your sword. But that bastard had it coming. Trust me, says your internal dialogue. I know.\n\n" if @corpse == true && @losecounter == 9
  puts "\nYou're pretty sure that with this algorithm it's just about possible to win a watermelon battle without your sword. And you refuse to reset and avoid killing your future self in another playthrough just so you can keep your sword. That blighter DESERVED it.'\n\n" if @corpse == true && @losecounter == 11

  puts "\nYou remember that sword which you left lying around... maybe that could help...\n\n" if @corpse == false && !(@inventory.include? "Sword") && (@losecounter % 3 == 0) && !(@losecounter == 0)
  
  #new text for future battles
  @watermelonroom.text = "
You're in a fantastically huge hall filled with endless watermelons, plus a relatively small#{" but gradually growing" if @losecounter > 1} pile of watermelon corpses, surrounded with buzzing flies.

The old lady looks you in the eye and asks, 'So, will you play another round?'

"
end



@watermelonroom.text = "\nYou enter a fantastically huge hall, perhaps a storehouse -- after all, it is full of watermelons. Thousands upon thousands of watermelons. A wizened old woman approaches. You quickly note the katana at her side.

'Welcome, brave warrior,' says the woman. 'I have been expecting you. You wish to leave this dungeon, do you not?'

'Yes, I do,' you say.

'I, myself, do not want you to leave this dungeon. I'm under orders from the DUNGEON MASTER herself to prevent you from leaving, in fact. However, I'll make you an offer. If you can defeat me at a game of watermelon smashing, I'll let you pass.'

'How does that work?' you ask.

'Simple. We both start with 50WP (WP stands for Watermelon Points). We take turns at smashing watermelons - one minute each. Each watermelon we smash subtracts one WP from our opponent's total. The first player to reduce their opponent to 0WP wins.'

'Why not just call it first to fifty and leave it at that?'

'Shush! Now, will you play?'\n\n"
@watermelonroom.menu1 = "'I will.'"
@watermelonroom.menu2 = "'I need a bit longer to prepare.' (Go back east)"
@watermelonroom.output1 = @watermelonroom
@watermelonroom.output2 = @hubroom
@watermelonroom.action1 = @watermelonbattle

#begin
puts "
Welcome to Silly Test Game! In this game there are no winners, only bugs.

In this game you are plunged into a terrifying dungeon, filled with magic, wonder and horror. To win, you must escape with your life, sanity, and preferrably also dignity. All you know is that the exit is somewhere to the EAST... good luck!

Enter 'q' at any time to quit.
"

loop do
  
  #determine win state
  if @outcome == "You win!"
    puts "\nThe old lady bows to you and gestures to the door. You are free to leave. \n\n"
    puts "You walk past thousands of watermelons and exit the chamber. The door clicks as it shuts behind you.\n\n"
    if @newtonnote == true
      puts "Suddenly you remember something really smart you could have said to Einstein and Newton. You try to open the door again, but to no avail.\n\n"
    end
    puts "Sighing, you take a deep breath of fresh air, close the console, and get up to pee.

THE END"
    break
  end

  #prepare variables
  @output1 = @currentroom.output1 
  @output2 = @currentroom.output2 
  @output3 = @currentroom.output3 
  @output4 = @currentroom.output4 
  @action1 = @currentroom.action1 if @currentroom.action1
  @action2 = @currentroom.action2 if @currentroom.action2
  @action3 = @currentroom.action3 if @currentroom.action3
  @action4 = @currentroom.action4 if @currentroom.action4

  #key (maybe better elsewhere?)
  if (@inventory.include? "Bottom half of a key") && (@inventory.include? "Top half of a key")
  puts "\nThe two halves of the key attract each other with such force that they explode on impact! Turns out they were neodymium magnets. Who knew.\n"
  @inventory.delete("Bottom half of a key")
  @inventory.delete("Top half of a key")
  end

  #print text
  puts @currentroom.text

  puts "1. #{@currentroom.menu1}" if @currentroom.menu1
  puts "2. #{@currentroom.menu2}" if @currentroom.menu2
  puts "3. #{@currentroom.menu3}" if @currentroom.menu3
  puts "4. #{@currentroom.menu4}" if @currentroom.menu4

  #suspicious (This would probably be better placed elsewhere...)
  @northroom.text = "\nThat stack of pancakes looks REALLY suspicious.\n\n" if @suspicious == true && !(@inventory.include? "Top half of a key")

  #input and processing
  @input = gets.chomp

    case @input.downcase 
    when "1"
      @currentroom.menu1
      @action1.call if @currentroom.action1 
      @currentroom = @output1 
    when "2"
      @currentroom.menu2
      @action2.call if @currentroom.action2
      @currentroom = @output2
    when "3"
      @currentroom.menu3
      @action3.call if @currentroom.action3
      @currentroom = @output3
    when "4"
      @currentroom.menu3
      @action4.call if @currentroom.action4
      @currentroom = @output4    
    when "i" 
      if @inventory.empty? && @applecore == true
        puts "\nYou look in your backpack. There is a mummified apple core inside. Not daring to touch it directly, you tip it out.\n"
        @applecore = false
      elsif @inventory.empty?
        puts "\nYou look in your backpack. It contains a conspicuous lack of apples.\n"
      else
        puts "\nInventory contents:", @inventory
      end
    when "q"
      break
    else puts "error" 
    end

end