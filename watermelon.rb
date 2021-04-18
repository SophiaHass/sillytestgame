
#watermelonroom
katanathing = false
outcome = nil
drawnote = false
losecounter = 0
makez = nil
who = nil
slicey = "smashed"
yourWP = nil
herWP = nil
round = 1
inventory = [] # !!! JUST FOR TESTING
corpse = false #!!!

herround = Proc.new do

  hersmash = rand(5..20)
  yourWP = yourWP - hersmash
  if yourWP < 0
    yourWP = 0
  end

  if katanathing == false 
     puts "\nThe old lady pulls out her katana and slices watermelons with expert skill and extreme focus. She bows to her defeated foes before sheathing her sword again."
     katanathing = true
  end 
 
  puts "\nThe old lady sliced #{hersmash} watermelons!\n"

  if yourWP == 0
    outcome = "You lose!"
    losecounter +=1
  end

end

yourround = Proc.new do
        
          if inventory.include? "Sword" 
            smashy = rand(5..20) + 2 
            slicey = "sliced"
          else
            smashy = rand(0..15)
          end
        herWP = herWP - smashy
        if herWP < 0
          herWP = 0
        end

        puts "\nYou #{slicey} #{smashy} watermelons!\n"
        if herWP == 0
          outcome = "You win!"
         end
end

watermelonbattle = Proc.new do

     yourWP = 50
     herWP = 50
     round = 1
     youstart = nil
     shestarts = nil

  if corpse == true && losecounter == 0
    puts "\nThe watermelon battle begins. Your hand instinctively goes to your hip, before realising that you broke your sword. If only you still had it...\n\n"
  end 

     #initiative roll
     herroll = rand(1..20) + 4
     yourroll = rand(1..29) - 2
     if yourroll > herroll
          youstart = true
          who = "you"
          makez = "make"
     else 
          shestarts = true
          who = "she"
          makez = "makes"
     end

  puts "\nYou and the old lady stare each other down. After a brief, silent battle of wits, #{who} #{makez} the first move!\n"

      loop do 
        puts "\nRound ##{round}. Press enter to smash watermelons.\n"
        inputter = gets
        round += 1

        if youstart
          yourround.call
          herround.call if outcome == nil
        elsif shestarts
          herround.call
          yourround.call if outcome == nil
        end

        puts "\nYour WP: #{yourWP}"
        puts "\nOld lady's WP: #{herWP}"
        break if outcome

      end

     end





watermelonbattle.call