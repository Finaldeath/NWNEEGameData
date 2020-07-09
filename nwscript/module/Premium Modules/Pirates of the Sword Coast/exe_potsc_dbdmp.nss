//::///////////////////////////////////////////////
//:: exe_potsc_dbdmp
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Dump all Module Plot variables to database.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////

const string sCampaign = "POTSC_DATABASE";

void StoreIntToDB(object oLocal, string sIndex);

void main()
{
    object oModule = GetModule();

    //Mark the Database as active.
    SetCampaignInt(sCampaign, "POTSC_DB_ACTIVE", TRUE);

//+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
// Plot Variables for Act 0
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A0_DOCKS - Shore Leave
//------------------------------------------------------------
//10 The captain needs some errands taken care of before you can sail to Calimshan. Go to the silver sails and get a passengers statue loaded.
//20 The Captain nees you to meet a last minute passenger at the Golden apple. Escort her back the the midnight rose.
//30 Everything is done and the captain is ready to get underway. Finish up any business you have in the Neverwinter Docks, there's no telling when you'll be back this way again.
//40 You have set sail and are on track for Calimshan, it will be a long journey.
    StoreIntToDB(oModule, "A0_DOCKS");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A0_CARGO - Loading Cargo
//------------------------------------------------------------
//10 PC has received the Plot from Allendry
//20 Knows Martins is missing from his post at the silver sails
//30 Found Martins in the tavern
//40 Heard Martins Story.
//50 Convinced the Dockhands to load the Statue
//60 Dock hands Ran Away.
//70 You have learned that you may be able to levitate the statue into place with the help of Rahman and a scroll locked in his room aboard the Midnight Rose.
//80 Gained the levitation spell to move the statue.
//90 Levitated the Statue
    StoreIntToDB(oModule, "A0_CARGO");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A0_ESCORT - Escorting Tasina
//------------------------------------------------------------
//10 Player has received the Tasina Escort quest from Allendry
//20 Learned Tasina is upstairs and shady characters are after her
//30 Defeated Brigands leading an assault on Tasina’s room
//40 Tasina has opened the door and joined the PC’s party
//50 Tasina is safely aboard the Midnight Rose
    StoreIntToDB(oModule, "A0_ESCORT");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A0_TATTOO - A Tattoo in Neverwinter
//------------------------------------------------------------
//10 There is a Tattoo parlor in the north section of the docks, maybe you should stop in.
//20 You have decided to get a tattoo of a ROPE & ANCHOR while in Neverwinter. It allows you to cast BULL'S STRENGTH (10) once a day.
//30 You have decided to get a tattoo of a HEART & ARROW while in Neverwinter. It allows you to cast ENDURANCE (10) once a day.
//40 You have decided to get a tattoo of a EYE & TEARS while in Neverwinter. It allows you to cast OWL'S WISDOM (10) once a day.
//50 You have decided to get a tattoo of a GNAKED GNOME while in Neverwinter. It allows you to cast EAGLE'S SPLENDOR (10) once a day.
//60 You started the quest but didn't finish it before leaving Neverwinter
    StoreIntToDB(oModule, "A0_TATTOO");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A0_AMBUSH - Dealing with Dela
//------------------------------------------------------------
//10 The PC has met Dela and has agreed to meet her in the ally for trade
//20 Dela is friendly to the PC and will sell her goods freely
//30 Dela has ambushed the in the ally way
//40 Dela has been killed during her attempted ambush.
//50 You started the quest but didn't finish it before leaving Neverwinter.
    StoreIntToDB(oModule, "A0_AMBUSH");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A0_TURFWR - Gangs of Neverwinter
//------------------------------------------------------------
//10 The PC has been cornered by a group of thugs calling themselves "Black River Bandits".
//20 The PC has been rescued by a group of Bloodsailors wandering the area. Unfortunately an all out gang war has errupted out into the streets. You should help out and end the conflict.
//30 The Bandits have fallen to the cunning of the player but in the fonfusion the local Blood sailors have fallen under the assumption that the Player is a member of the bandit gang. You must defend yourself and end the turf war.
//40 You have successfully taken down one of the Blackriver bandit's hideouts
//50 You have successfully taken down one of the Bloodsailor's hideouts
//60 You have successfully taken down two of the Blackriver bandits hideouts
//70 You have successfully taken down two of the Bloodsailor's hideouts
//80 You have successfully taken down three of the Blackriver bandits hideouts
//90 You have successfully taken down three of the Bloodsailor's hideouts
//100 With your help the Bloodsailors have taken control of the Docks, the turf war is over.
//110 With your help the Blackriver Bandits have regained control of the Docks, the turf war is over.
//120 You started the quest but didn't complete it before leaving Neverwinter.
    StoreIntToDB(oModule, "A0_TURFWR");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A0_SEIGE - Trouble in Paradise
//------------------------------------------------------------
//10 The Captain hasn't been on deck for hours. This isn't like him, it would be a good idea to find out what's holding him up.
//20 You've learned that the Captian has been hold up in his quarters with the Lady Preistess and the Mage. You should probably find out what's going on.
//30 You'll need something to enhance your hearing if your to listen in on their conversation. Maybe you can find a cup in the hold.
//40 Tasina has captured the Midnight Rose, killed Captain Allendry, and thrown you overboard.
    StoreIntToDB(oModule, "A0_SEIGE");


//+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
// Plot Variables for Act 1
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A1_ESCP - Escape from Troglodyte Island
//------------------------------------------------------------
//10 The Player has awoken on a desserted Island on the Sea of Swords. You must Escape.
//20 You have aquired some wood. With the right plans you could make a sturdy craft.
//30 You have aquired some plans for a raft. With some sturdy would you could escape the island.
//40 You have aquired both the Plans for a raft and the Wood to build it. Now all you need to do is put them together.
//50 You have escaped the Troglodyte island.
    StoreIntToDB(oModule, "A1_ESCP");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A1_NATIVES - Troglodytes!
//------------------------------------------------------------
//10 The Player found the corpse of a fellow sailor and has seen the footprints in the sand.
//20 Player has stumbled across a group of Troglodytes drawing a map in the sand.
//30 The player has read the map. He/She now knows that there is a strange cave to the east, and a path to a troglodyte encampment on the west of the island.
//40 The player has read the map but cannot make out the writing, but it is clear that there are important structures to the east and west
//50 The Player has met the Troglodytes and has been forced to battle their strongest warrior, Garm.
//60 A player has collected the equipment he needs and has agreed to go out and fight Garm.
//70 You defeated the Troglodyte Champion, Garm, in ritual combat and he is now your servant. The King of the Troglodytes requests to see you.
//80 You have defeated Garm but refused to eat him, he will wait for you in the Village until you agree to devout him one day. (CUT)
//90 To gain the Kings facor the PC has been tasked with hunting down and defeating the Ghost in the cave. The King has also said that if you defeat the "Old God" you would be sacred enough to touch the wood.
//100 The player has returned the Dwarfs Head to the Troglodyte King. The player can now get the Troglodytes to build him/her a raft off the island.
//110 The Player has attacked the troglodytes and is now their sworn enemy, there is no way to negotiate with them now.
//120 The player has stolen the sacred wood from the Troglodyte camp. In doing so the Camp has vowed revenge and is hunting the player.
//130 The player has escaped the troglodyte island and is underway to Spindrift.
    StoreIntToDB(oModule, "A1_NATIVES");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A1_DWARF - Of Gods and Monsters
//------------------------------------------------------------
//10 The player has found a map in the sand pointing out a Strange Cave to the east of the island.
//20 The Troglodyte King has given the player directions to a mysterious haunted monster cave on the east side of the jungle.
//30 The Player has been threatened by a strange flaming avatar. However, nothing is stopping the Player from entering the cavern the monster guards.
//40 The Player has entered the mysterious, trap ridden, cave. Corpses of troglodytes line the walls.
//50 The Player has met the mad, Dwarven inventor, Edgrimm.
//60 The PC has learned Edgrimm needs wood to make a raft, bring him wood and he’ll take you off the island.
//70 Edgrimm has taken offence to your threats and has decided to kill you.
//80 The Player has fought and Killed the Crazed inventor and captured the plans.
//90 The Player has taken the Stolen wood to Edgrimm. Edgrimm will now Build a boat and take the PC to Spindrift.
    StoreIntToDB(oModule, "A1_DWARF");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A1_SURVIV
//------------------------------------------------------------
//10 To survive the harsh island that is now your prison you will need to find a place to camp and light a fire. There should be some sutable places on the island.
//20 You have found a safe place to rest, all you need is a fire to keep away the preditors of the island as night falls.
//30 You finally have a Fire, if only you could bring it with you where ever you travel. If you could put together a make shift torch if would be a lot easier to safely explore the island.
//40 With a readied torch you are ready to take on the wilds of this untamed land. While not all preditors will flee from your fire, it should protect you from the simple creatures dwelling here.
//50 You left the island without ever equipping a torch.
    StoreIntToDB(oModule, "A1_SURVIV");


//+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
// Plot Variables for Act 2
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_SPNDRF - Tasina…
//------------------------------------------------------------
//10 The PC has washed up on the shore of Spindrift island.
//20 The PC has learned that Tasina is actually an Umberleen Priestess and has recently arrived in Spindrift.
//30 You can enter the Temple of Umberlee in Spindrift and interact with the guards and priestesses. They speak of Tasina's return with the statue, but you’re told that you are not allowed to meet with her, as she's engaged in an important ritual inside.
//40 The PC has learned that they may be able to enter the temple if they have a sufficent disguise. Pegleg seems to be holding onto just such an item.
//50 You have received the Robe and learned that a secondary entrance to the temple is hidden somewhere in the sewers.
//60 The PC has snuck into the lower level of the Temple of Umberlee.
//70 The PC confronts Tasina in the temple and attempts to attack her. She flees and takes the statues with her to Fiddler's Green.
//80 The PC confronts Tasina in the temple but lets her leave in peace. She flees and takes the statues with her to Fiddler's Green.
    StoreIntToDB(oModule, "A2_SPNDRF");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_MIDROSE - Stealing the Midnight Rose
//------------------------------------------------------------
//10 You Hear the Midnight Rose is in Port in Spindrift
//20 You’ve found the Rose in Harbor, but to man it you’ll need a five man crew and a clear sky
//30 You’ve gathered a Crew, but until the weather changes there’s little you can do.
//40 Tasina has Left port with the Midnight Rose. She’s headed out to an ancient Undersea temple.
    StoreIntToDB(oModule, "A2_MIDROSE");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_NECRO - The Skull and Bones
//------------------------------------------------------------
//10 The Captain of the Skull and Bones is looking for a crew. The Captain will take you anywhere you like if you can fill his roster of five.
//20 The crew is ready but until the storm subsides there is no way you can set sail. Maybe you should talk to some one in the Temple of umberlee.
//30 You’ve gathered a full crew and the weather is perfect. Kolmarr is ready to leave when you are.
//40 The Captain needs to make a quick stop before delivering you to your destination.
    StoreIntToDB(oModule, "A2_NECRO");


//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_CREW - Crews Control
//------------------------------------------------------------
//10 To sail a ship you’ll need atleast a five man crew. If you plan on leaving Spindrift by sea, you should probably start now.
//20 You have gained the loyalty of 1 skilled sailor.
//30 You have gained the loyalty of 2 skilled sailors.
//40 You have gained the loyalty of 3 skilled sailors.
//50 You have gained the loyalty of 4 skilled sailors.
//60 You’ve gathered a full five man crew.
    StoreIntToDB(oModule, "A2_CREW");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_REDTIP - Potential Crewmember:  Redtip the Minotaur
//------------------------------------------------------------
//10 There is a Fighter in the warehouse known to be a sailor of some skill. Perhaps he will join your crew.
//20 Red-Tip has declared that he will not leave Spindrift till his winning streak in the fight pit comes to an end.
//30 Red-Tip has been defeated.
//40 Red-Tip has agreed to join the crew.
//50 You started the quest but left Spindrift without completing it.
    StoreIntToDB(oModule, "A2_REDTIP");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_SHAKEY - Potential Crewmember: Shakey McGuire
//------------------------------------------------------------
//10 There is a shaky sailor in the Temple of Umberlee. He is very expeicanced if not a little high strung, maybe he'll join your crew.
//20 You and failed to sufficently terrify Shaky’s into joining your crew. Instead he has run off.
//30 After a pacifying dialog with Shaky he has agreed to join your crew.
//40 After an intimidating dialog Shaky McGuire has agreed to follow you out to sea when your ready.
//50 You started the quest but left Spindrift without completing it
    StoreIntToDB(oModule, "A2_SHAKEY");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_WHIPD - Potential Crewmember: Whipped Willigan
//------------------------------------------------------------
//10 There is a sailor called Willigan in a manor near the docks. He is know to be highly experianced, maybe he will join your crew.
//20 You have agreed to help out old Grog Beard’s friend Whipped Willigan. A ladder has been put up behind his house leading to the study where he hides out.
//30 You have met Willigan and he has agreed to join your crew if you can liberate him from his house. To do this you will need to recover three items his wife has hidden from him (his Pirate Garb, cutless, and fine leather boots).
//40 Willigan now has all of his belongings.
//50 Willigan is a free man, he waits to sail with you at the monkey’s cutless.
//60 You started the quest but left Spindrift without completing it
    StoreIntToDB(oModule, "A2_WHIPD");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_WWCTLS - Whipped Willigan: Trusty Cutlass
//------------------------------------------------------------
//10 Whipped Willigan’s cutless is a work of art. However it has been hidden away from him by his sinister wife and her meddling sisters.
//20 You have obtained Willigan’s Cutless.
//30 Willigans wife has taken the cutless back and hidden somewhere in the home. You'll need to start your search all over again.
//40 You have successfully delivered Willigan’s Cutless.
//50 You started the quest but left Spindrift without completing it
    StoreIntToDB(oModule, "A2_WWCTLS");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_WWCTLS - Whipped Willigan: Trusty Cutlass
//------------------------------------------------------------
//10 Whipped Willigan’s Garb is the very pinnacle of Pirate fashion. However, it has been hidden away from him by his sinister wife and her meddling sisters.
//20 You have obtained Willigan’s Garb.
//30 Willigans wife has taken the Garb back and hidden somewhere in the home. You'll need to start your search all over again.
//40 You have successfully delivered Willigan’s Garb.
//50 You started the quest but left Spindrift without completing it
    StoreIntToDB(oModule, "A2_WWGARB");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_WWBOOT - Whipped Willigan: Fine Leather Boots
//------------------------------------------------------------
//10 Whipped Willigan’s Fine Leather Boots were the talk of the town back in his sailing days. However, they have been hidden away from him by his sinister wife and her meddling sisters.
//20 You have obtained Willigan’s Boots.
//30 Willigans wife has taken the Fine leather boots back and hidden somewhere in the home. You'll need to start your search all over again.
//40 You have successfully delivered Willigan’s Boots.
//50 You started the quest but left Spindrift without completing it
    StoreIntToDB(oModule, "A2_WWBOOT");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_PEGLEG - Potential Crewmember: Pegleg Paulson
//------------------------------------------------------------
//10 Pegleg Paulson is a regular of the Monkeys Cutlass. Apparently he’s a sailor of some reputation, if only you could convince him to join the crew of the Skull and Bones.
//20 Word is the Pegleg has a weakness for ladies and the sauce. With a drink or two and a bit of flirting it shouldn’t be difficult to convince him to join the crew of the Skull and Bones.
//30 You’ve given Pegleg Paulson too much liqueur. He’s passed out, it maybe some time before he regains consciousness.
//40 Pegleg Paulson has agreeed to join your crew.
//50 You started the quest but left Spindrift without completing it
    StoreIntToDB(oModule, "A2_PEGLEG");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_PEGLEG - Potential Crewmember: Pegleg Paulson
//------------------------------------------------------------
//10 You have heard of a  Priestess of Umberlee called sweet marie. She doesn’t seem to like here position in the Clergy and is known as a sailor of some reputation. Maybe you could convince her to join you crew.
//20 Sweetie Marie won’t join. She’s waiting for something, and the sailor PegLeg in the Monkeys cutless may know how to convince her.
//30 You’ve learned of Sweet Maries love of wild flowers, if you can bring her some she’ll surely join your crew.
//40 You have found some of Sweet Maries favorite flowers. Bring them to her and she will surely join your crew.
//50 Sweetie Marie has agreed to join your crew.
//60 You started the quest but left Spindrift without completing it
    StoreIntToDB(oModule, "A2_SWEET");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_VANTAB - Potential Crewmember: Vantabular Garsp
//------------------------------------------------------------
//10 Vantabular is known in the area as an excellent Navigator and crewman, He might make a good addition to you crew.
//20 Vantabular has agreed to swear loyalty to you if you can help him in a task. If you help him solve the lighthouse puzzle and acquire the treasure he’ll join your crew.
//30 You have unlocked a secret passage under the light house and are one step closer to uncovering the mysterious treasure.
//40 The treasure has been discovered. Vantabular has taken possession of a magical golden sextant. He will now sail with your crew once your ready.
//50 You started the quest but left Spindrift without completing it
    StoreIntToDB(oModule, "A2_VANTAB");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_VANTAB - Potential Crewmember: Vantabular Garsp
//------------------------------------------------------------
//10 Get Vengaul the scepter of storms from the temple of umberlee and he will join your crew. To aid you, you have received a map of the inside of the umberlant temple, where the scepter resides.
//20 Player has acquired the scepter
//30 Vengaul has the Scepter, he will now wait in the Monkey's cutless for you to set sail.
//40 You started the quest but left Spindrift without completing it
    StoreIntToDB(oModule, "A2_BLOODS");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_BLACKR - Potential Crewmember: Honeypea
//------------------------------------------------------------
//10 Get HoneyPea the scepter of storms from the temple of umberlee and she will join your crew. To aid you, you have received a map of the inside of the umberlant temple, where the scepter resides.
//20 Player has acquired the scepter.
//30 HoneyPea has the Scepter, she will now wait in the Monkey's cutless for you to set sail.
//40 You started the quest but left Spindrift without completing it
    StoreIntToDB(oModule, "A2_BLACKR");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_FRANC - Potential Crewmember: Sir Francis
//------------------------------------------------------------
//10 You have heard of an able bodied sailor by the name of Sir Francis wandering about near the Fit pits.
//20 You have met sir Francis and have learned that he is looking for a ring.
//30 Sir francis has told you about Rascally Pete and how the sewer goer was the original owner and that francis's debt is to Pete.
//40 Has the player gotten the impression that Pete actually stole his ring from francis    and is still in possession of it?
//50 After failing to trick Pete out of the Ring Pete has attacked the PC. Pete is dead and the PC has the ring.
//60 The Player has paid Francis's debt and received the stolen ring from Pete.
//70 The PC has successfully tricked Pete out of the ring and it is now in their posession.
//80 Francis is now free of his debt and will join the PC's crew.
//90 You started the quest but left Spindrift without completing it
    StoreIntToDB(oModule, "A2_FRANC");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_FRANC - Potential Crewmember: Sir Francis
//------------------------------------------------------------
//10 There is a guy in the local prison who may make a good crewman. His name is longneck langer.
//20 You have met Langer and he’s told you his story and given you some options one how to help him get out of the clink.
//30 After talking with the Mayor you’ve convinced him to free Langer and Drop the charges.
//40 After paying Langers Bail the Mayor has given Langer his Freedom.
//50 Langer has received an Extreme Pirate Makeover, now he can be exonerated.
//60 Langer has been notified of his freedom and can be found at the Monkey’s cutless
//70 Langer has successfully undergone the extreme pirate make over and can be found at the monkey’s cutless
//80 You started the quest but left Spindrift without completing it
    StoreIntToDB(oModule, "A2_LANGER");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//   A2_TTTST - Falstaff's Follies
//------------------------------------------------------------
//10 You have met the Jailed tattooist and he has told you about his situation.
//20 You have paid the tattooist’s bail, once you talk to him he’ll leave the jail.
//30 You have released the Tattooist and he has offered you a favor in return.
//40 You have gone to the tattooist and received a free tattoo for the IOU
//50 You have used your IOU to acquire an Extreme pirate make over for LANGER.
//60 You started the quest but left Spindrift without completing it
    StoreIntToDB(oModule, "A2_TTTST");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  A2_TATTOO - A Tattoo in Spindrift
//------------------------------------------------------------
//10 The Local tattooist seems to be in some legal trouble. He is currently in prison.
//20 The Local Tattoist is now free thanks to your help. You should probably stop by and see what designs he has.
//30 You have decided to get a tattoo of a SKULL & CROSSBONES while in Neverwinter. It allows you to cast NEGATIVE ENRGY BURST (10) once a day.
//40 You have decided to get a tattoo of a FLAMING SKULL while in Neverwinter. It allows you to cast FLAMELASH (10) once a day.
//50 You have decided to get a tattoo of UMBERLEE'S WAVES while in Neverwinter. It allows you to cast CALL LIGHTNING (10) once a day.
//60 You have decided to get a tattoo of a COPPER DRAGON while in Neverwinter. It allows you to cast DRAGON BREATH: SLOW once a day.
//70 You started the quest but left Spindrift without completing it
    StoreIntToDB(oModule, "A2_TATTOO");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  A2_TATTOO - A Tattoo in Spindrift
//------------------------------------------------------------
//10 The skull and bones has landed on the Island of the Dead. You should probably talk to Captain Kolmarr to learn more about his ultimate weapon.
//20 The PC will need to leave a crewman behind to activate the sigils. The PC should talk to Old Tom to acquire the necessary provisions.
//30 The PC has activated all of the magic sigils, you should go talk to Kolmarr at the top of the hill.
//40 The captain has made the PC undead as well as the crew of the Skull and Bones. The only strange part is that the PC isn’t under the control of the Captain, like all the others. A battle begins and the PC must fight for his Un-Life or be destroyed.
//50 The Pirate Captain is defeated and his ship the skull and bones is now yours. You should return the the dock and talk to Old Tom.
//60 You have set sail after the Midnight Rose, you and the whole crew can feel the pull of the Rose now that you exist in a state of unlife.
    StoreIntToDB(oModule, "A3_DEAD");


//+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
// Plot Variables for Act 2
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  A3_HUNT - Sigils of the Damned
//------------------------------------------------------------
//10 The PC has gained the maps where the solutions to the maps have been buried. During the exchange Old Tom started to act strangely and gave the PC a strange amulet, saying something about “needing it more then the maps to survive this”.
//20 The PC has activated the First of Five locations.
//30 The PC has activated the Second of Five locations.
//40 The PC has activated the Third of Five locations.
//50 The PC has activated the Fourth of Five locations.
//60 The PC has activated all Five locations. Time to go talk to Kolmarr on the top of the hill.
//70 Kolmarr has opened a strange gate at the top of the hill and entered the portal. He has told you to follow him.
    StoreIntToDB(oModule, "A3_HUNT");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  A3_SEIGE - A Sinking Feeling...
//------------------------------------------------------------
//10 The PC has left the island of the Dead and is now underway to the temple. However, in the night as the player sleeps the ship comes under attack and the crew starts knocking at the door. Once the PC answers it the seige of the sahaugin begins.
//20 The PC has woke from a terrible dream involving a swarm of sahaugin attempting to seige the Skull and bones. Is this some sort of premonition of what's to come? (The player failed the Siege and the Ship sank, make them replay it.)
//30 Sahaugin have attacked the Skull and Bones. The crew is trapped fighting on the upper decks and you are down in the hold. To make matters worse the Sahaugin have drilled up through the Hull and are sinking the ship.
//40 You have successfully plugged the Holes in the Hull, now to finish off the sahaugin.
//50 You have repelled the Sauhagin attack.
    StoreIntToDB(oModule, "A3_SEIGE");

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  A3_WATER - Fiddler's Green
//------------------------------------------------------------
//10 You have sailed to the location of the Temple but it seems that you have only reached the epicenter of a storm. There is no island, only the Midnight Rose floating alone in the waters.
//20 Before things get any worse the Spirit of Allendry appears. He tells you that the directions were correct, but the temple is at the bottom of the. He doesn’t know where the temple is, but he can get you safely to the bottom.
//30 You have successfully navigated your way to the ocean floor. Now to find the temple!
//40 As you approach the Temple entrance a mysterious monster appears and destroys the path. You’ll have to find another way around.
//50 After finding yourself in the center of a feeding frenzy a Bronze dragon appears and fends of the sharks. He promised to keep the Umberlant Beast busy if you’ll promise to destroy the temple from the inside.
//60 After swearing to the Bronze Dragon that you would save Tasina you have been allowed to enter the secret entrance to the Umberlant Temple.
//70 The PC has found Tasina and she has agreed to stop the ceremony, once this occurs the Umberlant Guardian shows up and starts to demolishing the temple to get at you and your party.
//80 The PC has challenged Tasina and she has drawn on the full power of the Umberlant statues. She has been possessed by an Avatar of Umberlee and is trying to destroy you.
//90 The PC has saved Tasina, play ending.
//100 The PC has Killed Tasina, play ending.
    StoreIntToDB(oModule, "A3_WATER");
}

void StoreIntToDB(object oLocal, string sIndex)
{
    int iValue = GetLocalInt(oLocal, sIndex);
    SetCampaignInt(sCampaign, sIndex, iValue);
}

