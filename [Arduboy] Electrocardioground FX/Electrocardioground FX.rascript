// Electrocardioground FX
// #ID = 29339
// md5: cb860501a5f16a84fe2359e4498d0fe4

// =====================  Outline ===================== 

// # Progress
// Reach 100 points in Gentle mode
// Complete Gentle Mode (Win Condition)

// # Challenge
// Reach 60 points in Endless Mode
// Reach 90 points in Endless Mode
// Reach 130 points in Endless Mode
// Complete Gentle Mode without stomping any beat
// Keep the columns at less than 30% health for 100 score points (Gentle Mode recommended)
// Complete Gentle Mode without any column reaching less than 90% health


// ===================== Useful Address functions ======================

// $01C2: [8-bit] Beat Stomped this round?
//        0x00 = False
//        0x01 = True
function beat_stomped_this_round() => byte(0x0001C2)

// $01C8: [8 bit] Amount of Beats on screen
function amount_of_beats_on_screen() => byte(0x0001C8)

// $01CA: [16bit] Score
function score() => word(0x0001CA)

// $01CE: [8-bit] Game Mode
//        0x00 = Gentle
//        0x01 = Endless
function game_mode() => byte(0x0001CE)

// $01D8: [8-bit] Game Status
//        0x00 = Title
//        0x01 = Game
//        0x02 = Death
//        0x03 = Complete
function game_status() => byte(0x0001D8)
status_title = 0
status_game = 1
status_death = 2
status_complete = 3 //applies to Gentle Mode only

// $065F: [16bit] Left Column Life
function left_column_life() => word(0x00065F)

// $0665: [16bit] Right Column Life
function right_column_life() => word(0x000665)



// ===================== Helper functions ======================

// function died() {}

low_health_threshold = 80
high_health_threshold = 100

function is_gentle_mode() => game_mode() == 00
function is_endless_mode() => game_mode() == 01

function won_gentle() {
    return game_mode() == 00 && game_status() == 03 && prev(game_status())==01
}

function is_playing() {
    return game_status() == status_game
}

function started_playing() {
    return game_status() == status_game && prev(game_status()) == status_title
}

function in_title() {
    return game_status() == status_title
}

function dead(){
    return game_status() == status_death
}

function beat_stomped(){
    return beat_stomped_this_round() == 01
}

function columns_at_low_health(){
    return left_column_life() < low_health_threshold && right_column_life() < low_health_threshold
}

function columns_at_high_health(){
    return left_column_life() > high_health_threshold && right_column_life() > high_health_threshold
}

function disable_in_title(){
    return never(game_status() == status_title)
}

// ===================== Rich Presence =================

modeLookup = {
    0: "Gentle",
    1: "Endless",
}

rich_presence_conditional_display(in_title(), "Title Screen")

rich_presence_conditional_display(game_status() == 03, "Gentle Mode Complete!")

rich_presence_conditional_display(dead(), "Dead! Mode: {0}. Score {1}",
    rich_presence_lookup("Mode", game_mode(), modeLookup),
    rich_presence_value("Score", score())
)
rich_presence_display("Keeping the beat alive. Mode: {0}. Score {1}",
    rich_presence_lookup("Mode", game_mode(), modeLookup),
    rich_presence_value("Score", score())
)


// ==================== Achievement Functions ===================


achievement(title = "Bradycardia", 
            description = "Reach 100 points in Gentle mode", 
            points = 3,
            trigger = is_playing() && is_gentle_mode() && score() >= 100,
            badge="475346"
            )

achievement(title = "Sinus Rhythm", 
            description = "Complete Gentle Mode", 
            points = 5,
            trigger = is_playing() && won_gentle(),
            badge="475347"
            )

function endless_score(title, target_score, points, badge){
    achievement(title = title, 
            description = "Reach " + target_score + " points in Endless mode", 
            points = points,
            trigger = is_playing() && is_endless_mode() && score() >= target_score,
            badge = badge
            )
}
 
endless_score("Fibrillation", 60, 5, "475348")
endless_score("Arrhythmia", 90, 10, "475349")
endless_score("Tachycardia", 130, 25, "475350")


achievement(title = "Ahimsa", 
            description = "Complete Gentle Mode without stomping any beat", 
            points = 10,
            trigger = once(started_playing()) && never(dead())  && never(beat_stomped()) && trigger_when(won_gentle()),
            badge="475351"
            )

achievement(title = "Palpitation", 
            description = "Complete Gentle Mode without any column reaching less than 80% health", 
            points = 10,
            trigger = once(started_playing()) && never(dead()) && never(!columns_at_high_health()) && trigger_when(won_gentle()),
            badge="475353"
            )
            
achievement(title = "Ischemia", 
            description = "Keep the columns at less than 65% health for the duration of 65 score points (Gentle Mode recommended)", 
            points = 5,
            trigger = never(!is_playing()) && never(!columns_at_low_health()) && trigger_when(repeated(65, score() > prev(score()))),
            badge="475352"
            )
            

// ======================== Leaderboards ===========================

leaderboard("Endless Score", "How far can you make it in Endless Mode?", is_playing() && is_endless_mode(), in_title(), dead(), score(), format="VALUE", lower_is_better=false, id=0)
