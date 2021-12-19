// Flower, Sun, and Rain: Murder and Mystery in Paradise
// #ID = 9496
// md5: 24757b6de971131ebcf174cc91694216 - Europe

//Note: These are all on Save File 1. not on RAM.

// TODO: check if notes should reference a specific group or bit lenght

function steps() => dword(0x09CA18) // Steps/Pedometer (On Save Data _1)
function current_request() => byte(0x09CA74) // Highest unlocked request (On Save Data _1), in game they start from #00
function after_intro() => bit0(0x0a0522) == 1
function during_intro() => bit0(0x0a0522) == 0

rich_presence_display(" Request #{0} | {1} Steps taken",
    rich_presence_value("Request", current_request())
    rich_presence_value("Lives", steps())
)

//===================== Core Progression ==================================

function cheev_complete_request(request, points, title)
{
    achievement(
        title = title, 
        description = "Complete Request #" + (request-1), 
        points = points,
        trigger = current_request() == request + 1 && prev(current_request()) == request && after_intro()
                  && prev(steps()) > 0 //Duct tape quality Save protection, check if steps were more than 1 in the previous frame
    )
}



cheev_complete_request(0, 5, "Peter Bocchwinkur")
cheev_complete_request(1, 5, "Christina")
cheev_complete_request(2, 5, "Stephan Charbonie")
cheev_complete_request(3, 5, "El-Crasher")
cheev_complete_request(4, 5, "Maria Nicharesuk")
cheev_complete_request(5, 5, "Sonny Balboa")
cheev_complete_request(6, 5, "Yayoi Hanayama")
cheev_complete_request(7, 5, "Shoutaro Kai")
cheev_complete_request(8, 5, "Yuuri Otowaya")
cheev_complete_request(9, 5, "Ken Sakurapee")
cheev_complete_request(10, 5, "Mati Sding")
cheev_complete_request(11, 5, "Sue Sding")
cheev_complete_request(12, 5, "Edo Macalister")
cheev_complete_request(13, 5, "Remy Fawzil")
cheev_complete_request(14, 5, "Yoshimitsu Koshimizu")
cheev_complete_request(15, 5, "Natsuko Akai")
cheev_complete_request(16, 5, "Sandance Ritz")
cheev_complete_request(17, 5, "Toriko Kusabi")
//cheev_complete_request(18, 25, "Sumio Mondo0")



//========== Single Bit Game Clear and Costumes ==========

function cheev_single_bit(address, points, title, description){
    achievement(
        title = title, 
        description = "Title", 
        points = points,
        trigger = address == 1 && prev(address) == 0 && after_intro() 
                  && prev(steps()) > 0 //Duct tape quality Save protection, check if steps were more than 1 in the previous frame
    )    
}

cheev_single_bit(bit5(0x09ca1d), 25, "Sumio Mondo", "Clear the Game")

cheev_single_bit(bit6(0x09ca1d), 5, "Traditional", "Obtain the Kimono Costume")
cheev_single_bit(bit7(0x09ca1d), 5, "Neigh!", "Obtain the Horse Costume")
cheev_single_bit(bit0(0x09ca1d), 5, "A Tres Caídase", "Obtain the Luchador Costume")
cheev_single_bit(bit1(0x09ca1d), 5, "Room Service", "Obtain the Hotel Staff Uniform")
cheev_single_bit(bit2(0x09ca1d), 5, "Vacation", "Obtain the Tourist Clothes")
cheev_single_bit(bit3(0x09ca1d), 5, "No More Heroes", "Obtain the Travis Touchdown Costume")

//==================== Lost and Found items (tickets) =====================================
    
 // Tire, statue and giggs Lost Items
 
function cheev_items(title, request, item_1, item_2, item_3){
achievement(
    title = title, 
    description =  "Collect all 3 Lost & Found Tickets for Request #" + request, 
    points = 5,
    trigger = never( during_intro() ) &&
              ( once( item_1 + item_2 + item_3 == 2 )  )  && // save Protection
              ( item_1 + item_2 + item_3 == 3 ) 
    )      
    
}    

cheev_items("Miniature Giggs", 0, bit0(0x09c9f1), bit1(0x09c9f1), bit2(0x09c9f1))  // Tire, statue, Miniature Giggs 
cheev_items("Slippers", 1, bit3(0x09c9f1), bit4(0x09c9f1), bit5(0x09c9f1))  // Picture, Cards, Slippers    
cheev_items("Toy Horse", 2, bit6(0x09c9f1), bit7(0x09c9f1), bit0(0x09c9f2))  // Ring, Lighter, Toy Horse
cheev_items("Mask", 3, bit1(0x09c9f2), bit2(0x09c9f2), bit3(0x09c9f2)) // Wallet, Address Book, Mask
cheev_items("Grasshopper Cocktail", 4, bit4(0x09c9f2), bit5(0x09c9f2), bit6(0x09c9f2)) // Cocktail, Hat, PC,
cheev_items("Bathing Suit", 5, bit7(0x09c9f2), bit0(0x09c9f3), bit1(0x09c9f3)) // Wine, Bathing Suite, Movie Flyer
cheev_items("Mr Charbonie's Pot", 6, bit2(0x09c9f3), bit3(0x09c9f3), bit4(0x09c9f3)) // Record, Pot, Pinball Token
cheev_items("Miss Hanayama's Makeup", 7, bit5(0x09c9f3), bit6(0x09c9f3), bit7(0x09c9f3)) //Makeup, Yukata, Black Suite
cheev_items("Coconut", 8, bit0(0x09c9f4), bit1(0x09c9f4), bit2(0x09c9f4)) // Bow Tie, Score, Coconut
cheev_items("Eleking Model", 9, bit3(0x09c9f4), bit4(0x09c9f4), bit5(0x09c9f4)) // Pendant, Highway Receipt, Eleking Model
cheev_items("Beach Sandals", 10, bit6(0x09c9f4), bit7(0x09c9f4), bit0(0x09c9f5)) // Diner Flyer, Dinner Statue, Beach Sandals
cheev_items("Stuffed Horse", 11, bit1(0x09c9f5), bit2(0x09c9f5), bit3(0x09c9f5)) //Pendang, Bag, Stuffed Horse
cheev_items("Edo's Diary", 14, bit4(0x09c9f5), bit5(0x09c9f5), bit6(0x09c9f5)) //Movie Flyer, Edo's Diary, Shorts
cheev_items("Miniature of Ruins", 15, bit7(0x09c9f5), bit0(0x09c9f6), bit1(0x09c9f6)) //Record, Wrist Wratch, Miniature of Ruins
cheev_items("Aloha Shirt", 16, bit2(0x09c9f6), bit3(0x09c9f6), bit4(0x09c9f6)) //Fruit Basket, Model of Hotel Sign, Aloha Shirt
cheev_items("Collar", 17, bit5(0x09c9f6), bit6(0x09c9f6), bit7(0x09c9f6)) //Collar Pudding Champion Belt
cheev_items("Model Aircraft", 18, bit0(0x09c9f7), bit1(0x09c9f7), bit2(0x09c9f7)) // Diner Menu Toilet Deodoriser, Model Aircraft

//TODO, check if a ticket is removed when exchanged for the prize, in that case use the prize IDs, not the ticket ID

//========== Steps ==========
function achievement_steps(steps, points, title)
{
    achievement(
        title = title, 
        description = "Walk " + steps + " Steps",
        points = points,
        trigger = after_intro() && steps() == steps && prev(steps()) == (steps-1) 
    )
}

achievement_steps(1000, 5, "Idle Steps") //Walk 1,000 steps to open the Search System
achievement_steps(5000, 5, "A vacant Stroll") // Walk 5,000 steps to upgrade the Search System
achievement_steps(10000, 5, "An empty Walk")
achievement_steps(20000, 5, "A blank Jog")
achievement_steps(30000, 5, "A desserted Hike")
achievement_steps(40000, 5, "A pointless Trip")
achievement_steps(50000, 5, "A Journey to owhere")
achievement_steps(75000, 10, "An Achievement of emptiness")
achievement_steps(100000, 25, "True Gamer") //Walk 100,000 steps to fully upgrade the Search System
