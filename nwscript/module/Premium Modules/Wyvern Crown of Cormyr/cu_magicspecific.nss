// This is the Wyvern Crown version of this ibrary. Do not use anywhere else.
// B W-Husey
// October 2005

//************************************************************************
// Custom Magic Treasure Function for generating magic treasure of varying types in placeable, store or creature
// B W-Husey, JAN 2005 - cu_magicspecific now holds tables of magic broken into type
// See cu_treasure, cu_magic, cu_magichi and cu_magicvariable for other types of generation
// Treasure Types are:
//        Ammunition
//        Jewelry (rings & amulets)
//        Clothing (Gloves, gauntlets, cloaks, clothing, belt & boots)
//        Misc
//        Wizardry (rods, wands, spellbooks, staves)
//        Weapon
//        Armour (including shields, armour, helmets & bracers/armlets)
//The command is GetTreasureType(sTreasureset,oCreateIn,nChance,nLevel,nItems)
//Inputs: sTreasureSet - The name of the group of treasure as above
//        oCreateIn    - The object to contain the treasure
//        nChance      - Chance of any of this type
//        nLevel  - In this file, it sets the level of treasure - rough guidance
//                            1 = suitable for PCs of lvls 1-2,
//                            2 = lvls 3-5,
//                            3 = lvls 4-7,
//                            4 = lvls 6-10,
//                            5 = lvls 9+
//        nItems - The number of this type of items (i.e. number of rolls, not number in stack)
void GetTreasureType(string sTreasureSet, object oCreateIn=OBJECT_SELF, int nChance=100, int nLevel=1, int nItems=1);


void GetTreasureType(string sTreasureSet, object oCreateIn=OBJECT_SELF, int nChance=100, int nLevel=1, int nItems=1)
{
// FloatingTextStringOnCreature(IntToString(nLevel),GetFirstPC());
if (Random(100)+1<nChance)  // First check to see if treasure is generated
{
string sItem = "nw_wswdg001";           //default item = dagger
int nStack=1;                           //default 1 in stack
int rnd;                                //define variables
int nReroll = 0;                        //used to reroll if nothing generated (i.e. space for later)
int nSpecial = 0;                       //Used to override level (i.e. go up a table)

//=================================Ammunition============================
if (sTreasureSet == "Ammo")           //Ammunition
    {
    int iNumb=0;
    while (iNumb<nItems)
    {
        rnd = Random(20);
        nStack = d20()+d3(); //Ammo stacks should be more than 1!
        //*****debug line***************
        ////SendMessageToPC(GetFirstPC(),"Rolling: level "+IntToString(nLevel)+" value "+IntToString(rnd));

        if (nLevel == 1) //Higher level then go to next set
        { //Table 1
         if (rnd < 2) sItem = "pinpointarrows";   //Pinpoint Arrows
         else if (rnd <4 ) sItem = "nw_wammbu001";   //Giant's Bane
         else if (rnd <6) sItem = "scribingarrows";    //Scribing Arrows
         else if (rnd <8) sItem = "flamearrows";     //Flame arrows
         else if (rnd <10) sItem = "silverarrows";   //Silver Arrows
         else if (rnd <11) sItem = "nw_wammar009";   //+1 Arrows
         else if (rnd <12) sItem = "nw_wammbo008";   //+1 Bolts
         else if (rnd <13) sItem = "nw_wammbu008";   //+1 Bullets
         else if (rnd <15) nReroll = 1;   //Space for new items - roll again
         else if (rnd <20) {nSpecial = 2;  rnd = Random(20);} //Bonus - up to next table
        }
        if ((nLevel == 2) || (nSpecial == 2))
        { rnd = rnd + 20; //Table 2
         if (rnd <21) sItem = "vampiricdarts";          //Vampiric Darts
         else if (rnd <22) sItem = "bleeder";     //Bleeders
         else if (rnd <23) sItem = "darkarrow";         //Dark Arrows
         else if (rnd <24) sItem = "nw_wammar008";     // Poison Arrows
         else if (rnd <25) sItem = "x2_wammbo001";       //Teleport bolts
         else if (rnd <26) sItem = "boltsofdivine";  //Bolts Divine Wrath
         else if (rnd <27) sItem = "bleeders";       //Bleeders
         else if (rnd <28) sItem = "boltsofsapping";    //Bolts of Sapping
         else if (rnd <29) sItem = "nw_wammbo003";    //Paralytic bolts
         else if (rnd <30) sItem = "nw_wammar010";    //+2 Arrows
         else if (rnd <31) sItem = "nw_wammbo009";    //+2 Bolts
         else if (rnd <32) sItem = "nw_wammbu009";    //+2 Bullets
         else if (rnd <33) sItem = "nw_wammar001";    //Vampyric Arrows
         else if (rnd <34) sItem = "nw_wammar007";    //Mild Poison Arrows
         else if (rnd <38) nReroll = 1;   //Space for new items - roll again
         else if (rnd <40) {nSpecial = 3;  rnd = Random(20);} //Bonus - up to next table
        }
        if ((nLevel == 3) || (nSpecial == 3))
        { rnd = rnd + 40; //Table 3
         if (rnd <42) sItem = "boltsofmighty";       //Bolts Mighty Wrath
         else if (rnd <44) sItem = "nw_wammbu005";      //Fire Bullets
         else if (rnd <46) sItem = "nw_wammar004";      //Arrows of Piercing
         else if (rnd <48) sItem = "nw_wammbo002";      //Bolts of Lightning
         else if (rnd <50) sItem = "nw_wammbu002";      //Screaming bullets
         else if (rnd <100) nReroll = 1 ; //Too High
        }
        // Next line immediately makes any items above the first
//        FloatingTextStringOnCreature("Creating a level "+IntToString(nLevel),GetFirstPC());
//        FloatingTextStringOnCreature("rnd is "+IntToString(rnd),GetFirstPC());
//        FloatingTextStringOnCreature("reroll is "+IntToString(nReroll),GetFirstPC());
//        FloatingTextStringOnCreature("nSpecial is "+IntToString(nSpecial),GetFirstPC());
        if ((nItems-iNumb)>1 && nReroll<1) CreateItemOnObject(sItem, oCreateIn, nStack); // All potions except last created by this line
//        if ((nItems-iNumb)>1 && nReroll<1)         FloatingTextStringOnCreature("I DID create an item",GetFirstPC());
        if (nReroll<1) iNumb ++; //Increment as long as we got an item
        nSpecial = 0;
        nReroll = 0;
    } //End of While Loop
    } //End of Ammo If


//=================================Jewelry============================
if (sTreasureSet == "Jewelry")  //Rings & Amulets (level 1 many not magic)
    {
    int iNumb=0;
    while (iNumb<nItems)
    {
        rnd = Random(30); //Higher level then go to next set
        //*****debug line***************
        //SendMessageToPC(GetFirstPC(),"Rolling: level "+IntToString(nLevel)+" value "+IntToString(rnd));
        if (nLevel == 1)
        { //Table 1
         if (rnd < 1)  sItem = "nw_it_mring021";        //Copper Ring
         else if (rnd <2) sItem = "nw_it_mring022";     //Silver Ring
         else if (rnd <3) sItem = "nw_it_mneck020";     //Copper Necklace
         else if (rnd <4) sItem = "nw_it_mneck021";     //Silver Necklace
         else if (rnd <5) sItem = "nw_it_mring023";     //Gold Ring
         else if (rnd <6) sItem = "nw_it_mneck022";     //Gold Necklace
         else if (rnd <7) sItem = "jewelledring";       //Jewelled Ring
         else if (rnd <8) sItem = "nw_it_mneck023";     //Glittering Necklace
         else if (rnd <9) sItem = "mindstar";   // Mindstar
         else if (rnd <10) sItem = "necromulet";     //    Necromulet
         else if (rnd <12) sItem = "nw_it_mneck001";       //Armour +1
         else if (rnd <13) sItem = "nw_it_mneck006";       //Scarab Prot +1
         else if (rnd <14) sItem = "nw_it_mring012";          //Insight
         else if (rnd <15) sItem = "amuletofextraabi";    //Amulet of extra abilities
         else if (rnd <18) sItem = "prayeramulet";    //Prayer Amulet
         else if (rnd <19) sItem = "coppertalisman";    //Talisman
         else if (rnd <20) sItem = "irontalisman";    //Talisman
         else if (rnd <21) sItem = "brasstalisman";    //Talisman
         else if (rnd <22) sItem = "ridersring";    //Rider's Ring
         else if (rnd <28) nReroll = 1;   //Space for new items - roll again
         else if (rnd <30) {nSpecial = 2;  rnd = Random(30);} //Bonus - up to next table
        }
        if (nLevel == 2 || nSpecial == 2)
        { rnd = rnd + 30; //Table 2
         if (rnd <31) sItem = "brightstaramulet";   // Brightstar Amulet
         else if (rnd <33) sItem = "lesserringofp";    //Lesser ring of protection
         else if (rnd <34) sItem = "nw_it_mneck032"; //Resist Acid
         else if (rnd <35) sItem = "nw_it_mneck030"; //Resist Cold
         else if (rnd <36) sItem = "nw_it_mneck029"; //Resist Elect
         else if (rnd <37) sItem = "nw_it_mneck031"; //Resist Fire
         else if (rnd <38) sItem = "x2_it_mneck001"; //Vitality +2
         else if (rnd <39) sItem = "x2_it_mneck035"; //Lesser Health
         else if (rnd <40) sItem = "merchantsring";   // Merchant's Ring
         else if (rnd <41) sItem = "lifeprotector";     //Life Protector
         else if (rnd <42) sItem = "ringofturning";        //Ring of Turning
         else if (rnd <43) sItem = "nw_it_mneck008";        //Wisdom +2
         else if (rnd <44) sItem = "x0_it_mring008";        //Bone Ring
         else if (rnd <45) sItem = "x0_it_mring013";    //Purple Dragon Ring
         else if (rnd <46) sItem = "nw_it_mring014";    //Clear Thought +2
         else if (rnd <47) sItem = "x0_it_mring010";    //Protection Disease
         else if (rnd <48) sItem = "nw_it_mring031";    //Resistance +1
         else if (rnd <49) sItem = "x2_it_mring006";    //Ring of the Ram
         else if (rnd <50) sItem = "ringofwar";    //Ring of War
         else if (rnd <52) sItem = "prayerring";    //Prayer Rin
         else if (rnd <53) sItem = "ringofthorns";    //Ring of Thorns
         else if (rnd <54) sItem = "stalwartring";    //Stalwart Ring
         else if (rnd <55) sItem = "spellprotector";    //Stalwart Ring
         else if (rnd <56) sItem = "hypnoticamulet";    //Hypnotic Amulet
         else if (rnd <57) sItem = "sentientamulet";    //Sentient Amulet

//         else if (rnd <56) nReroll = 1;   //Space for new items - roll again
         else if (rnd <60) {nSpecial = 3;  rnd = Random(30);} //Bonus - up to next table
        }
        if (nLevel == 3 || nSpecial == 3)
        { rnd = rnd + 60; //Table 3
         if (rnd <62) sItem = "greaterringof";      //Greater ring of protection
         else if (rnd <64) sItem = "ringofice";            // Ring of Ice
         else if (rnd <66) sItem = "nw_it_mneck017";   //Scarab +3
         else if (rnd <68) sItem = "x0_it_mring006";          //Ring of Freedom
         else if (rnd <70) sItem = "enchantring";        //Enchanted Ring
         else if (rnd <72) sItem = "x0_it_mring014";        // Ring of Spell Battle
         else if (rnd <73) sItem = "supremeringof";        //Supreme ring of Protection
         else if (rnd <75) sItem = "morphions";            //Morphion's Covetous Ring
         else if (rnd <77) sItem = "ringofflame";         //Ring of Flame
         else if (rnd <78) sItem = "x0_it_mring012";  //Ring of 9 lives
         else if (rnd <80) sItem = "forestersring";     //Forester's Ring
         else if (rnd <82) sItem = "ringofchange";     //Ring of change
         else if (rnd <84) sItem = "ringofthecent";     //Ring of centaur
         else if (rnd <100) nReroll = 1 ; //Too High
        }
        // Next line immediately makes any items above the first
        if ((nItems-iNumb)>1 && nReroll<1) CreateItemOnObject(sItem, oCreateIn, nStack); // All potions except last created by this line
        if (nReroll<1) iNumb ++; //Increment as long as we got an item
        nSpecial = 0;
        nReroll = 0;
    } //End of While Loop
    } //End of jewelry If

//=======================================Clothing=========================
if (sTreasureSet == "Clothing")  //Clothing: Gloves, gauntlets, cloaks, clothing, belt & boots
    {
    int iNumb=0;
    while (iNumb<nItems)
    {
        rnd = Random(30); //Higher level then go to next set
        //*****debug line***************
        //SendMessageToPC(GetFirstPC(),"Rolling: level "+IntToString(nLevel)+" value "+IntToString(rnd));
        if (nLevel == 1)
        { //Table 1
         if (rnd < 2) sItem = "beltoflight";          //Belt of Light
         else if (rnd <3 ) sItem = "thievesboots";   // Thieves Boots
         else if (rnd <5 ) sItem = "acidrobe";        //Acid Robe
         else if (rnd <7) sItem = "firerobe";        //Fire Robe
         else if (rnd <8) sItem = "beldinsbelt";    //
         else if (rnd <9) sItem = "girdleoffireresi";       //Girdle of Fire resistance
         else if (rnd <10) sItem = "girdleofmight";    //
         else if (rnd <11) sItem = "craftersgloves";    //Crafter's Gloves
         else if (rnd <12) sItem = "nw_it_maarcl031";    //Nymph +1
         else if (rnd <13) sItem = "nw_it_mglove008";    //Discipline
         else if (rnd <14) sItem = "nw_it_mglove014";    //Great Discipline
         else if (rnd <15) sItem = "nw_it_mglove015";    //Great Swordplay
        else if (rnd < 17) sItem = "softleatherboo";  // Soft leather boots
        else if (rnd < 18) sItem = "cloakofdarkness";  // Cloak of Darkness
         else if (rnd <19) sItem = "cloakofhelm";     //Cloak of Helm
         else if (rnd <20) sItem = "nw_it_mbelt009";     //Belt of sword/bludg/pierc
         else if (rnd <21) sItem = "nw_it_mbelt010";     //
         else if (rnd <22) sItem = "nw_it_mbelt011";     //
         else if (rnd <23) sItem = "cloakofearth";     //
         else if (rnd <24) sItem = "huntmastersclo";     //
         else if (rnd <25) sItem = "glovesofstriki";     // Gloves of Striking
         else if (rnd <30) {nSpecial = 2;  rnd = Random(30);} //Bonus - up to next table
        }
        if (nLevel == 2 || nSpecial == 2)
        { rnd = rnd + 30; //Table 2
         if (rnd <32) sItem = "icerobe";        //Ice Robe
         else if (rnd <34) sItem = "shockrobe";        //Shock Robe
         else if (rnd <35) sItem = "dancersboots";       //Dancer's Boots
         else if (rnd <36) sItem = "paladinsgloves";       //Paladin's Gloves
         else if (rnd <37) sItem = "robesofretalia";       //Robes of Retaliation   - OK2
         else if (rnd <38) sItem = "beltofabsorbti";       //Belt of Absorbtion
         else if (rnd <39) sItem = "bootsofthewoods";       //Boots of the woods
         else if (rnd <40) sItem = "nw_it_mboots006";       //Striding +2
         else if (rnd <41) sItem = "barbariancloak";       //Barbarian Cloak
         else if (rnd <42) sItem = "x0_it_maarcl026";       //Resistance +2
         else if (rnd <43) sItem = "championsgaunt";        //Champion's Gauntlets
         else if (rnd <44) sItem = "smithsgloves";       //Smith's gloves
         else if (rnd <45) sItem = "nw_it_mbracer013";       //Gauntlets of Ogre Power
         else if (rnd <46) sItem = "nw_it_mglove001";       //Wondrous Gloves
         else if (rnd <47) sItem = "cloakoftheowl";       //Cloak of the owl
         else if (rnd <48) sItem = "snakeskincloak";       //Snakeskin Cloak
         else if (rnd <49) sItem = "cloakoftorm";     //Cloak of Torm
         else if (rnd <50) sItem = "cloakofcyrric";     ///Cloak of Cyrric
         else if (rnd <51) sItem = "cloakofredra";     //Cloak of Red Dragon
         else if (rnd <52) sItem = "cloakofbluedr";     //Cloak of Blue Dragon
         else if (rnd <53) sItem = "cloakofreflect";     //Cloak of Reflection
         else if (rnd <54) sItem = "firecape";     //Fire Cape
         else if (rnd <55) sItem = "girdleoftheho";     //Girdle of the Holy
         else if (rnd <56) sItem = "glovesofmis";     //Gloves of Mishandling
         else if (rnd <57) sItem = "abyssalgloves";     //Abyssal gloves
//         else if (rnd <55) nReroll = 1;   //Space for new items - roll again
         else if (rnd <60) {nSpecial = 3;  rnd = Random(30);} //Bonus - up to next table
        }
        if (nLevel == 3 || nSpecial == 3)
        { rnd = rnd + 60; //Table 3
         if (rnd <62) sItem = "nw_it_mbelt002";       //Hill Giant Strength Belt
         else if (rnd <64) sItem = "wandererscloak";    //Wanderer's Cloak
         else if (rnd <66) sItem = "robesofmight";         //Robes of Might
         else if (rnd <68) sItem = "bootsofthehar";        //Boots of the Hardy
         else if (rnd <70) sItem = "spellmantle";        //Spell Mantle
         else if (rnd <72) sItem = "nw_it_maarcl089";        //Protection +3
         else if (rnd <74) sItem = "drillmastersgl";        //Drillmaster's Gloves
         else if (rnd <76) sItem = "poisonersglove";        //Poisoner's Gloves
         else if (rnd <78) sItem = "ironcloak";        //Ironcloak
         else if (rnd <78) sItem = "elvencloak";        //Elven cloak
         else if (rnd <79) sItem = "cloakofgolddr";     //Cloak of Gold Dragon
         else if (rnd <80) sItem = "bigbysgloves";     //Bigby's Gloves
         else if (rnd <88) nReroll = 1;   //Space for new items - roll again
         else if (rnd <90) {nSpecial = 4;  rnd = Random(30);} //Bonus - up to next table
        }
        if (nLevel == 4 || nSpecial == 4)
        { rnd = rnd + 90; //Table 4
         if (rnd <93) sItem = "robesofthepuremi";    //Robes of the pure minded - ok4
         else if (rnd <96) sItem = "x0_cloth002";   //Robes of Lesser Eyes
         else if (rnd <99) sItem = "robesofthemoon";   //Robes of the Moon
         else if (rnd <101) sItem = "deftboots";              //Deft Boots
         else if (rnd <103) sItem = "x2_sequencer3";              //Isaac's Sequencer
         else if (rnd <105) sItem = "wizardsboots";         //Wizard's boots
         else if (rnd <120) nReroll = 1 ; //Too High
        }
        // Next line immediately makes any items above the first
        if ((nItems-iNumb)>1 && nReroll<1) CreateItemOnObject(sItem, oCreateIn, nStack); // All potions except last created by this line
        if (nReroll<1) iNumb ++; //Increment as long as we got an item
        nSpecial = 0;
        nReroll = 0;
    } //End of While Loop
    } //End of clothing If

//=======================================Misc=========================
if (sTreasureSet == "Misc")  //
    {
    int iNumb=0;
    while (iNumb<nItems)
    {
        rnd = Random(20); //Higher level then go to next set
        //*****debug line***************
        //SendMessageToPC(GetFirstPC(),"Rolling: level "+IntToString(nLevel)+" value "+IntToString(rnd));
        if (nLevel == 1)
        { //Table 1
         if (rnd < 1) sItem = "cavalryhorn"; //
         else if (rnd <2) sItem = "x0_it_mthnmisc08";    //Horn of blasting
         else if (rnd <3) sItem = "enchantingstone"; //
         else if (rnd <4) sItem = "purpleknowall"; //
         else if (rnd <5) sItem = "ivory"; //
         else if (rnd <6) sItem = "bagofwind"; //
         else if (rnd <8) sItem = "nw_it_contain003"; //Magic Bag
         else if (rnd <9) sItem = "warriorfigure"; //Warrior figure
         else if (rnd <10) sItem = "ladyfigure"; //Lady figure
         else if (rnd <11) sItem = "tribalcharm"; //Tribal Charm
         else if (rnd <12) sItem = "nw_it_contain004"; //Magic Bag
         else if (rnd <14) sItem = "skillstone"; //Skill Stone
         else if (rnd <15) sItem = "ghostseeds"; //Ghost Seeds
         else if (rnd <16) sItem = "silverchalice"; //Silver Chalice
         else if (rnd <17) sItem = "silvertradebar"; //Skill Stone
         else if (rnd <18) sItem = "x0_it_msmlmisc06"; //Heart of the beast
         else if (rnd <19) nReroll = 1;   //Space for new items - roll again
         else if (rnd <20) {nSpecial = 2;  rnd = Random(20);} //Bonus - up to next table
        }
        if (nLevel == 2 || nSpecial == 2)
        { rnd = rnd + 20; //Table 2
         if (rnd <21) sItem = "murderousdust";      //
         else if (rnd <22) sItem = "nw_it_contain005";    //Magic Bag
         else if (rnd <23) sItem = "platinumtradeb";          //Trade Bar
         else if (rnd <24) sItem = "magicmap";          //Magic Map
         else if (rnd <26) sItem = "kheotomsointme";          //Kheotom's Ointment
         else if (rnd <27) sItem = "nw_it_mmidmisc04";          //Scabbard of Bless
         else if (rnd <28) sItem = "x0_it_mthnmisc13";          //Elixir of Horus-Re
         else if (rnd <29) sItem = "twigmask";          //Twig Mask
         else if (rnd <30) sItem = "x0_it_mmedmisc01";          //Brooch of Shield
         else if (rnd <31) sItem = "vialofwisdom";    //Vial
         else if (rnd <32) sItem = "symbolofnature";    //Symbol of Nature
         else if (rnd <33) sItem = "x0_it_mthnmisc09";    //Horn of Good/Evil
         else if (rnd <34) sItem = "animalfigure";    //Animal Figure
         else if (rnd <35) nReroll = 1;   //Space for new items - roll again
         else if (rnd <40) {nSpecial = 3;  rnd = Random(20);} //Bonus - up to next table
        }
        if (nLevel == 3 || nSpecial == 3)
        { rnd = rnd + 40; //Table 3
         if (rnd <41) sItem = "shriekstone";    //Shriek Stone
         else if (rnd <42) sItem = "icestone";      //Ice Stone
         else if (rnd <43) sItem = "firestone";      //Fire Stone
         else if (rnd <44) sItem = "acidstone";      //Acid Stone
         else if (rnd <45) sItem = "shockstone";   //Shock Stone
         else if (rnd <49) sItem = "nw_it_contain006";    //Bag of Holding
         else if (rnd <50) sItem = "spiderfigurine";    //Spider Figurine
         else if (rnd <51) sItem = "bagofbones";    //Bag of Bones
         else if (rnd <53) sItem = "bagofbeans";    //Bag of Beans
         else if (rnd <55) sItem = "reddragonscale";    //Red Dragon Scale
         else if (rnd <56) sItem = "x0_it_mthnmisc11";    //Lens of Detection
         else if (rnd <57) sItem = "x0_it_mthnmisc18";    //Canaith Mandolin
         else if (rnd <58) sItem = "vialofstrength";    //Vial
         else if (rnd <59) sItem = "vialofdexterity";    //Vial
         else if (rnd <60) nReroll = 1;   //Space for new items - roll again
        }
        // Next line immediately makes any items above the first
        if ((nItems-iNumb)>1 && nReroll<1) CreateItemOnObject(sItem, oCreateIn, nStack); // All potions except last created by this line
        if (nReroll<1) iNumb ++; //Increment as long as we got an item
        nSpecial = 0;
        nReroll = 0;
    } //End of While Loop
    } //End of Misc If

//=======================================Wizardry=========================
if (sTreasureSet == "Wizardry")  //
    {
    int iNumb=0;
//debug    SendMessageToPC(GetFirstPC(),"Called");
    while (iNumb<nItems)
    {
        rnd = Random(20); //Higher level then go to next set
        //*****debug line***************
//SendMessageToPC(GetFirstPC(),"Rolling: level "+IntToString(nLevel)+" value "+IntToString(rnd));
        if (nLevel == 1)
        { //Table 1
         if (rnd < 2) sItem = "amberwand";                   //
         else if (rnd <4) sItem = "fearsomewand";              //
         else if (rnd <6) sItem = "wandoflight";              //
         else if (rnd <8) sItem = "wandoftrapdet";              //
         else if (rnd <10) sItem = "x2_it_cfm_wand";          //Bone Wand
         else if (rnd <12) sItem = "greatwandoflight";     //Wand of Light (Greater)
         else if (rnd <18) nReroll = 1;   //Space for new items - roll again
         else if (rnd <20) {nSpecial = 2;  rnd = Random(20);} //Bonus - up to next table
        }
        if (nLevel == 2 || nSpecial == 2)
        { rnd = rnd + 20; //Table 2
         if (rnd <21) sItem = "spellbook1";              //
         else if (rnd <22) sItem = "spellbook2";              //
         else if (rnd <23) sItem = "spellbook3";              //
         else if (rnd <25) sItem = "spellbook4";              //
         else if (rnd <26) sItem = "melfsrod";              //
         else if (rnd <27) sItem = "spellbook5";              //
         else if (rnd <28) sItem = "rodofterror";    //
         else if (rnd <29) sItem = "nw_wmgst006";    //Staff of the Holy
         else if (rnd <30) sItem = "shockingwand";      //Shocking Wand
         else if (rnd <31) sItem = "wandofdispelli";      //Wand of Dispelling
         else if (rnd <32) sItem = "nw_wmgwn004";      //Wand of Missiles
         else if (rnd <33) sItem = "wandoftheheav";      //Wand of the Heavens
         else if (rnd <35) nReroll = 1;   //Space for new items - roll again
         else if (rnd <40) {nSpecial = 3;  rnd = Random(20);} //Bonus - up to next table
        }
        if (nLevel == 3 || nSpecial == 3)
        { rnd = rnd + 40; //Table 3
         if (rnd <42) sItem = "rodofice";           //
         else if (rnd <44) sItem = "nw_wmgmrd002";         //Rod of resurrection
         else if (rnd <46) sItem = "staffofpower";      //
         else if (rnd <48) sItem = "wandofdeath";            //
         else if (rnd <50) sItem = "wandofflames";    //
         else if (rnd <51) sItem = "x2_it_wngrd001";    //Rod of Thunder & Lightning
         else if (rnd <60) nReroll = 1;   //Space for new items - roll again
        }
        // Next line immediately makes any items above the first
        if ((nItems-iNumb)>1 && nReroll<1) CreateItemOnObject(sItem, oCreateIn, nStack); // All potions except last created by this line
        if (nReroll<1) iNumb ++; //Increment as long as we got an item
        nSpecial = 0;
        nReroll = 0;
    } //End of While Loop
    } //End of Wizardry If

//=======================================Weapon=========================
if (sTreasureSet == "Weapon")  //Magic Weapons
    {
    int iNumb=0;
    while (iNumb<nItems)
    {
        rnd = Random(30); //Higher level then go to next set
        //*****debug line***************
        //SendMessageToPC(GetFirstPC(),"Rolling: level "+IntToString(nLevel)+" value "+IntToString(rnd));
        if (nLevel == 1)
        { //Table 1
         if (rnd < 1) sItem = "attercob";           //Attercob
         else if (rnd <2 ) sItem = "curseddagger";       //Cursed Dagger
         else if (rnd <3 ) sItem = "precisioncrossb";     //Precision Crossbow
         else if (rnd <4) sItem = "lightningaxe";       //Lightning Axe
         else if (rnd <5) sItem = "coldironknife";      //
         else if (rnd <6) sItem = "coldironblade";        //
         else if (rnd <7) sItem = "superiorlongswo";      //
         else if (rnd <8) sItem = "crafteddagger";        //Crafted Dagger
         else if (rnd <9) sItem = "lliirasstars";        //
         else if (rnd <10) sItem = "silverknife";        //Silver Knife
         else if (rnd <11) sItem = "longbowyew";        //Longbow, Yew
         else if (rnd <12) sItem = "luckstars";        //
         else if (rnd <13) sItem = "x2_wmdwraxe002";        //Dwarven Waraxe +1
         else if (rnd <14) sItem = "superiormace";        //Superior Mace
         else if (rnd <15) sItem = "drelbsshortbl";        //Drelb's Shortblade

         else if (rnd <25) nReroll = 1;   //Space for new items - roll again
         else if (rnd <30) {nSpecial = 2;  rnd = Random(30);} //Bonus - up to next table
        }
        if (nLevel == 2 || nSpecial == 2)
        { rnd = rnd + 30; //Table 2
         if (rnd <31) sItem = "pitilesssling";       //Pitiless Sling
         else if (rnd <32) sItem = "foeslayer";    //
         else if (rnd <33) sItem = "thewatcher";            //
         else if (rnd <34) sItem = "deneirsdagger";          //
         else if (rnd <35) sItem = "swordoflight";             //
         else if (rnd <36) sItem = "longswordoftyr";   //
         else if (rnd <37) sItem = "mililsblade";           //
         else if (rnd <38) sItem = "frostbrand";             //Frostbrand
         else if (rnd <39) sItem = "luckblade";             //
         else if (rnd <40) sItem = "puremight";             //
         else if (rnd <41) sItem = "lathandersmace";             //
         else if (rnd <42) sItem = "chaunteasscythe";             //
         else if (rnd <43) sItem = "huntersbow";             //
         else if (rnd <44) sItem = "nw_waxmgr008";    //Stonefire Axe +1
         else if (rnd <45) sItem = "nw_waxmhn008";    //Ice Reaver
         else if (rnd <46) sItem = "nw_wswmls009";    // Astral Blade +1
         else if (rnd <47) sItem = "nw_wdbmsw008";    // Uthgardt Blade
         else if (rnd <48) sItem = "nw_wplmsc008";    // Sea Reaver
         else if (rnd <49) sItem = "nw_wbwmln010";    // Composite Longbow +1
         else if (rnd <50) sItem = "nw_wbwmsh010";    // Composite Shortbow +1
         else if (rnd <51) sItem = "nw_wbwmsl005";    // Sunlight Sling
         else if (rnd <52) sItem = "drelbslong";        //Drelb's Longblade
         else if (rnd <53) sItem = "longswordofhel";        //Longsword of Helm
         else if (rnd <54) sItem = "horsebow";        //Horse Bow
         else if (rnd <55) nReroll = 1;   //Space for new items - roll again
         else if (rnd <60) {nSpecial = 3;  rnd = Random(30);} //Bonus - up to next table
        }
        if (nLevel == 3 || nSpecial == 3)
        { rnd = rnd + 60; //Table 3
         if (rnd <61) sItem = "blooddrinker";    //Blooddrinker
         else if (rnd <62) sItem = "bsoulsucker";              //Soulsucker Axe
         else if (rnd <63) sItem = "lsousucker";       // Soulsucker Sword
         else if (rnd <64) sItem = "nightblade";      //
         else if (rnd <65) sItem = "moonbane";      //
         else if (rnd <66) sItem = "slicer";              //
         else if (rnd <67) sItem = "blacksling";           //
         else if (rnd <68) sItem = "nw_waxmgr003";      //Netherese Axe
         else if (rnd <69) sItem = "nw_wswmbs005";          //Lawgiver
         else if (rnd <70) sItem = "nw_wswmdg004";              //Ice Talon
         else if (rnd <71) sItem = "nw_wswmls007";        //Holy Avenger
         else if (rnd <72) sItem = "nw_wblmhw005";             //Rift Hammer
         else if (rnd <73) sItem = "endlesscrossbow";      //Endless Crossbow
         else if (rnd <74) sItem = "nw_wplmss007";    // Briarspike
         else if (rnd <75) sItem = "dragonslayer";    // Dragonslayer
         else if (rnd <76) sItem = "kamaofthecobr";    //Kama of the Cobra
         else if (rnd <77) sItem = "starfire";    //Starfire
         else if (rnd <78) sItem = "blackstaff";    //Blackstaff
         else if (rnd <79) sItem = "drillmastersbl";    //Drillmaster's Blade
         else if (rnd <80) sItem = "thebutcher";    //The Butcher
         else if (rnd <81) sItem = "longblight";    //Longblight
         else if (rnd <82) sItem = "snakestaff";    //Snakestaff
         else if (rnd <83) sItem = "dancingblades";    //Dancing Blades
         else if (rnd <84) sItem = "chaoswhip";    //Chaos Whip
         else if (rnd <85) sItem = "catoninetail";    //Cat o' Nine Tails
         else if (rnd <86) sItem = "bane";         //Bane
         else if (rnd <87) sItem = "thebrute";         //The Brute
         else if (rnd <88) sItem = "sliver";         //Sliver
         else if (rnd <89) sItem = "fireknife";         //Fire Knife
//         else if (rnd <86) nReroll = 1;   //Space for new items - roll again
         else if (rnd <90) {nSpecial = 4;  rnd = Random(30);} //Bonus - up to next table
        }
        if (nLevel == 4 || nSpecial == 4)
        { rnd = rnd + 90; //Table 4
         if (rnd <91) sItem = "lifestealer";        //
         else if (rnd <92) sItem = "sunblade";      //
         else if (rnd <93) sItem = "carnage";         //
         else if (rnd <94) sItem = "nw_waxmhn006";             //Offhand axe
         else if (rnd <95) sItem = "nw_wswmgs003";          //Gemsword
         else if (rnd <96) sItem = "x1_wblmml001";             //Mace of Disruption
         else if (rnd <97) sItem = "x2_it_venomhb";              //Venom Halberd
         else if (rnd <98) sItem = "scimitarofspeed";         //Scimitar of Speed
         else if (rnd <99) sItem = "thunderhead";         //Thunderhead
         else if (rnd <100) sItem = "studdedblade";         //Studded Blade
         else if (rnd <101) sItem = "harpbow";         //Harp Bow
         else if (rnd <102) sItem = "bsoulsucker3";         //Dagger +2 soulsucker

         else if (rnd <120) nReroll = 1;   //Space for new items - roll again
        }
        // Next line immediately makes any items above the first
        if ((nItems-iNumb)>1 && nReroll<1) CreateItemOnObject(sItem, oCreateIn, nStack); // All potions except last created by this line
        if (nReroll<1) iNumb ++; //Increment as long as we got an item
        nSpecial = 0;
        nReroll = 0;
    } //End of While Loop
    } //End of weapon If

//=======================================Armour=========================
if (sTreasureSet == "Armour")  //Magic Armour, helms and armlets/bracers, shields
    {
    int iNumb=0;
    while (iNumb<nItems)
    {
        rnd = Random(30); //Higher level then go to next set
        //*****debug line***************
        ////SendMessageToPC(GetFirstPC(),"Rolling: level "+IntToString(nLevel)+" value "+IntToString(rnd));
        if (nLevel == 1)
        { //Table 1
         if (rnd < 1) sItem = "mixedblessing";          //Mixed Blessing
         else if (rnd <2) sItem = "finechainmail";       //Fine Chainmail
         else if (rnd <3) sItem = "fineplatemail";       //Fine Plate Mail
         else if (rnd <4) sItem = "1helmet";             //Helmet +1
         else if (rnd <5) sItem = "truesighthelm";       //True Sight Helm
         else if (rnd <6) sItem = "elvenchainshir";     //Elven chainshirt
         else if (rnd <7) sItem = "bracerofmalar";     //Bracer of Malar
         else if (rnd <8) sItem = "performersarml";     //Performer's Armlet
         else if (rnd <9) sItem = "runebracer";     //Rune Bracer
         else if (rnd <10) sItem = "nobleplate";     //Noble Plate
         else if (rnd <11) sItem = "armoroffrost";     //Armour of Frost

         else if (rnd <25) nReroll = 1;   //Space for new items - roll again
         else if (rnd <30) {nSpecial = 2;  rnd = Random(30);} //Bonus - up to next table
        }
        if (nLevel == 2 || nSpecial == 2)
        { rnd = rnd + 30; //Table 2
         if (rnd <31) sItem = "championshelm";      //Champion's helm
         else if (rnd <32) sItem = "helmofthesea";    //Helm of the sea
         else if (rnd <33) sItem = "murderoushelm";       // Murderous Helm
         else if (rnd <34) sItem = "saintlyhelm";       // Saintly Helm
         else if (rnd <35) sItem = "chaosmail";        //  Chaos Mail
         else if (rnd <36) sItem = "mailofthenoblehe";        // Mail of the Noble Heart
         else if (rnd <37) sItem = "archersbracer";        //Archer's Bracer
         else if (rnd <38) sItem = "armletofguidance";    // Armlet of Guidance
         else if (rnd <39) sItem = "nw_maarcl026";         //Gnomish Magnetic
         else if (rnd <40) sItem = "nw_armhe012";        //Greater Mask of Persuasion
         else if (rnd <41) sItem = "nw_it_novel004";      //Moonstone Mask
         else if (rnd <42) sItem = "nw_maarcl013";     //Armor of Thorns
         else if (rnd <43) sItem = "helmdragonred";     //Helm of the Red Dragon
         else if (rnd <44) sItem = "helmdragonbronze";     //Helm of the Bronze Dragon
         else if (rnd <45) sItem = "helmdragonsilver";     //Helm of the Silver Dragon
         else if (rnd <46) sItem = "mailoffleetnes";     //Mail of Fleetness
         else if (rnd <47) sItem = "bronzebreastpla";     //Bronze Breastplate
         else if (rnd <49) sItem = "crusaderhelm";     //Crusader Helm
         else if (rnd <50) sItem = "bloodhelm";     //Blood Helm
         else if (rnd <51) sItem = "archersjerkin";     //Archer's Jerkin
         else if (rnd <52) sItem = "greenheart";     //Greenheart
         else if (rnd <55) nReroll = 1;   //Space for new items - roll again
         else if (rnd <60) {nSpecial = 3;  rnd = Random(30);} //Bonus - up to next table
        }
        if (nLevel == 3 || nSpecial == 3)
        { rnd = rnd + 60; //Table 3
         if (rnd <61) sItem = "chivalrousplate";           //
         else if (rnd <62) sItem = "mailoftheblac";     //
         else if (rnd <63) sItem = "greatertruesigh";      // Greater True Sight Helm
         else if (rnd <64) sItem = "nightmaskleather";       //
         else if (rnd <65) sItem = "silvanusleathe";
         else if (rnd <66) sItem = "mailoftheslee";      //  Mail of the Sleeping Sword
         else if (rnd <67) sItem = "kemper";          //
         else if (rnd <68) sItem = "nw_maarcl042";        // Copper Dragon
         else if (rnd <69) sItem = "helmofstoicism";         //Helm of Stoicism
         else if (rnd <70) sItem = "nw_maarcl022";         //Elven Ceremonial
         else if (rnd <71) sItem = "nw_maarcl018";       //White Dragon
         else if (rnd <72) sItem = "mailoftheeagl";       //Mail of the Eagle
         else if (rnd <73) sItem = "spiritualshield";       //Spiritual Shield
         else if (rnd <74) sItem = "thunderstoneshi";       //Thunderstone Shield
         else if (rnd <75) sItem = "royalbandedmai";       //Royal Banded
         else if (rnd <76) sItem = "therighteousbl";       //The Righteous Black
         else if (rnd <77) sItem = "blackheartleath";       //Blackheart Leather
         else if (rnd <78) sItem = "purpledragonkn";       //Purple Dragon Knight Shield
         else if (rnd <85) nReroll = 1;   //Space for new items - roll again
         else if (rnd <90) {nSpecial = 4;  rnd = Random(30);} //Bonus - up to next table
        }
        if (nLevel == 4 || nSpecial == 4)
        { rnd = rnd + 90; //Table 4
         if (rnd <91) sItem = "nw_maarcl025";    //Balduran's armour
         else if (rnd <92) sItem = "nw_maarcl004";         //Armour of fleetness
         else if (rnd <93) sItem = "shieldofthetower";         //Shield of the Tower
         else if (rnd <94) sItem = "therighteouswh";       //The Righteous White
         else if (rnd <95) sItem = "deepwoodleather";       //Deepwood Leather
         else if (rnd <120) nReroll = 1;   //Space for new items - roll again
//         else if (rnd <120) {nSpecial = 5;  rnd = Random(30);} //Bonus - up to next table
        }
/*        if (nLevel == 5 || nSpecial == 5)
        { rnd = rnd + 120; //Table 4
         if (rnd <125) sItem = "";         //
         else if (rnd <130) sItem = "";         //
         else if (rnd <150) nReroll = 1 ; //Too High
        }
        */
        // Next line immediately makes any items above the first
        if ((nItems-iNumb)>1 && nReroll<1) CreateItemOnObject(sItem, oCreateIn, nStack); // All potions except last created by this line
        if (nReroll<1) iNumb ++; //Increment as long as we got an item
        nSpecial = 0;
        nReroll = 0;
    } //End of While Loop
    } //End of Armour If
    if (nStack == 0) nStack = 1;
    object oNew = CreateItemOnObject(sItem, oCreateIn, nStack);  // Create the first item
        //*****debug line***************
        //SendMessageToPC(GetFirstPC(),"Item "+sItem+" "+GetName(oNew));

}    //End of nChance
}    //End of Void


