// THIS IS THE WYVERN CROWN VERSION OF THIS FUNCTION - DO NOT USE ANYWHERE ELSE!
// B W-Husey
// Rebuilt October 2005

//************************************************************************
// Custom Magic Treasure Function for generating magic treasure of varying types in placeable, store or creature
// B W-Husey, 30th May 2003 - MAJOR CHANGE JAN 2005 - cu_magicspecific now holds tables of magic broken into type
// See cu_treasure for the remaining categories (split into two for compile ease)
// Treasure Types are:
//  Potions - Potions (up to 3 of them) (Any)
//   Scrolls1 - Level 0 & 1 scrolls (Bookcases, stores & Wizards)
//    Scrolls12 - Level 1 & 2 scrolls (Bookcases, stores & Wizards)
//    Scrolls34 - level 3 & 4 scrolls (Bookcases, stores & Wizards)
//    Scrolls56 - level 5 & 6 scrolls (Bookcases, stores & Wizards)
//    Weapon1 - +1 weapons (Containers and stores)
//    Weapon2 - +2 weapons (Containers and stores)
//    Armour1 - +1 Armour (Containers and stores)
//    Armour2 - +2 Armour (Containers and stores)
//    Major - Various gems (including major), jewelry, chance of minor magic (Containers, stores and some creatures: Bosses)
//    Books
// Inputs: sTreasureSet - The name of the group of treasure as above
// oCreateIn    - The object to contain the treasure
//  nChance      - Chance of any of this type
//  nBonus  - Not used in this version so you can ignore this one.
//  nDrop = Item is not droppable if set to 1
//  nEquip  if it = 1 equip the item (it's the other way around than GetTreasure, sorry!)
void GetMagic(string sTreasureSet, object oCreateIn=OBJECT_SELF, int nChance=100, int nBonus=0, int nDrop =0, int nEquip = 0);
/*
The following are found in cu_treasure and use GetTreasure():
    Gold10 - Up to 10 gold, bonus adds to quantity
    Gold100 - 10d10 Gold, bonus adds to quantity
    Misc - Various kits, torches, arrows, etc (Containers and Stores)
    Weapon - standard weapon (no club) (Any, creature arms)
    Armour - Armour, send a bonus for better stuff (Any, creature armour?)
    Minor - 1-3 gold, Various gems & non valuable rings, etc. (Containers, stores and some creatures: Bodyguards, etc)
    Gems - Any gem except ruby, diamond, sapphire, emerald (Containers and Creatures)
*/
//==============================end declarations======================================

void GetMagic(string sTreasureSet, object oCreateIn=OBJECT_SELF, int nChance=100, int nBonus=0, int nDrop =0, int nEquip = 0)
{
if (Random(100)+1<nChance)
{
string sItem = "nw_wswdg001";           //default item = dagger
int nStack=1;                           //default 1 in stack
int rnd;                                //define variables

if (sTreasureSet == "Potions")           //POTIONS
    {
    int counter=0;                       //Define variables
    int iNumb=0;
    int rnd2= Random(10)+1;              //Determine how many potions (1-3)
    if (rnd2<6) counter=1;
    else if (rnd2 <9 ) counter=2;
    else if (rnd2 <11 ) counter=3;

    while (iNumb<counter)
    {
        rnd = Random(53);
        //*****debug line***************
        //SendMessageToPC(GetFirstPC(),"Rolling Magic:  value "+IntToString(rnd));

        if (rnd < 4)
        { sItem = "nw_it_mpotion001";                   //Potion of Cure Light Wounds
        nStack=d2(); }
        else if (rnd <7 ) sItem = "nw_it_mpotion002";   //Potion of Cure Serious Wounds
        else if (rnd <9 ) sItem = "nw_it_mpotion003";   //Potion of Cure Critical Wounds
        else if (rnd <11) sItem = "nw_it_mpotion006";   //Potion of Antidote
        else if (rnd <13) sItem = "nw_it_mpotion011";   //Potion of Lesser Restoration
        else if (rnd <15) sItem = "nw_it_mpotion016";   //Potion of Aid
        else if (rnd <16) sItem = "nw_it_mpotion012";   //Potion of Heal
        else if (rnd <18) sItem = "nw_it_mpotion010";   //Potion of Eagle's Splendor
        else if (rnd <20) sItem = "nw_it_mpotion013";   //Potion of Endurance
        else if (rnd <22) sItem = "nw_it_mpotion014";   //Potion of Cat's Grace
        else if (rnd <24) sItem = "nw_it_mpotion015";   //Potion of Bull's Strength
        else if (rnd <26) sItem = "nw_it_mpotion017";   //Potion of Fox's Cunning
        else if (rnd <27) sItem = "nw_it_mpotion018";   //Potion of Owl's Wisdom
        else if (rnd <30) sItem = "nw_it_mpotion005";   //Potion of Barkskin
        else if (rnd <33) sItem = "nw_it_mpotion009";   //Potion of Bless
        else if (rnd <35) sItem = "nw_it_mpotion019";   //Potion of Lore
        else if (rnd <36) sItem = "nw_it_mpotion004";   //Potion of Speed
        else if (rnd <37) sItem = "nw_it_mpotion007";   //Potion of Clarity
        else if (rnd <38) sItem = "nw_it_mpotion008";   //Potion of Invisibility
        else if (rnd <42) sItem = "x2_it_cfm_pbottl";  //Potion Bottle
        else if (rnd <43) sItem = "x2_it_mpotion002";  //Ironguts
        else if (rnd <44) sItem = "x2_it_mpotion001";  //Death Armour
        else if (rnd <45) sItem = "potionofstonef";  //Stoneform
        else if (rnd <46) sItem = "polymorphjuice";  //Polymorph
        else if (rnd <47) sItem = "potionofeyes";  //See Invisible
        else if (rnd <48) sItem = "potionofprotec";  //Protection vs Spells
        else if (rnd <49) sItem = "potionofprayer";  //Prayer
        else if (rnd <50) sItem = "blackwaters";  //Aura of Glory
        else if (rnd <51) sItem = "trappotion";  //Trap detection
        else if (rnd <52) sItem = "nightpotion";  //Darkness
        else if (rnd <53) sItem = "potionofstonew";  //Stonewill
        if (counter-iNumb>1) {CreateItemOnObject(sItem, oCreateIn, nStack);} // All potions except last created by this line (last created at file end)
        iNumb ++;
    } //End of While Loop
    } //End of Potions If

if (sTreasureSet == "Books")         //Books
    {
    rnd = Random(22);
    if (rnd < 2) sItem = "wcbook10";                   //
    else if (rnd <3 ) sItem = "wcbook1";              //
    else if (rnd <4 ) sItem = "wcbook2";              //
    else if (rnd <5 ) sItem = "wcbook3";              //
    else if (rnd <6 ) sItem = "wcbook4";              //
    else if (rnd <7 ) sItem = "wcbook5";              //
    else if (rnd <8 ) sItem = "wcbook6";              //
    else if (rnd <9 ) sItem = "spellbook1";              //
    else if (rnd <10) sItem = "spellbook2";              //
    else if (rnd <11) sItem = "spellbook3";              //
    else if (rnd <12) sItem = "spellbook4";              //
    else if (rnd <13) sItem = "bookoflore";              //
    else if (rnd <14) sItem = "spellbook5";              //
    else if (rnd <15) sItem = "bookoflore";              //
    else if (rnd <16) sItem = "bookoflies";              //
    else if (rnd <17) sItem = "bookofhealers";              //
    else if (rnd <18) sItem = "bookofsmiths";              //
    else if (rnd <19) sItem = "wcbook7";              //
    else if (rnd <20) sItem = "wcbook8";              //
    else if (rnd <21) sItem = "wcbook9";              //
    else if (rnd <22) sItem = "wcbook11";              //
    }

if (sTreasureSet == "Scrolls1")         //SCROLLS LEVEL 0 & 1
    {
    rnd = Random(67);
        //*****debug line***************
        //SendMessageToPC(GetFirstPC(),"Rolling Magic:  value "+IntToString(rnd));
    if (rnd < 1)
    { sItem = "nw_it_sparscr003";                   // Daze
      nStack=2;}
    else if (rnd <2 )
    { sItem = "nw_it_sparscr004";                   //Light
      nStack=2;}
    else if (rnd <3 )
    { sItem = "nw_it_sparscr002";                   //Ray of Frost
      nStack=2;}
    else if (rnd <4 )
    { sItem = "nw_it_sparscr001";                   //Resistance
      nStack=2;}
    else if (rnd <6) sItem = "nw_it_sparscr112";    //Burning Hands
    else if (rnd <8) sItem = "nw_it_sparscr107";    //Charm Person
    else if (rnd <10) sItem = "nw_it_sparscr110";   //Color Spray
    else if (rnd <12) sItem = "nw_it_sparscr101";   //Endure Elements
    else if (rnd <14) sItem = "nw_it_sparscr103";   //Grease
    else if (rnd <16) sItem = "nw_it_sparscr106";   //Identify
    else if (rnd <18) sItem = "nw_it_sparscr104";   //Mage armour
    else if (rnd <20) sItem = "nw_it_sparscr109";   //Magic Missile
    else if (rnd <22) sItem = "nw_it_sparscr102";   //Protection from Alignment
    else if (rnd <24) sItem = "nw_it_sparscr111";   //Ray of Enfeeblement
    else if (rnd <26) sItem = "nw_it_sparscr108";   //Sleep
    else if (rnd <28) sItem = "nw_it_sparscr105";   //Summon Creature I
    else if (rnd <29) sItem = "doom";               //snap doom
    else if (rnd <30 )
    { sItem = "x1_it_sparscr001";                   //
      nStack=2;}
    else if (rnd <31 )
    { sItem = "x1_it_sparscr002";                   //
      nStack=2;}
    else if (rnd <32 )
    { sItem = "x1_it_sparscr003";                   //
      nStack=2;}
    else if (rnd <33 )
    { sItem = "x1_it_spdvscr001";                   //
      nStack=2;}
    else if (rnd <35) sItem = "x1_it_sparscr101";   //Exp. Retreat
    else if (rnd <37) sItem = "x1_it_sparscr102";   //Amplify
    else if (rnd <39) sItem = "x1_it_sparscr103";   //Shield
    else if (rnd <41) sItem = "x1_it_spdvscr102";   //Divine Favour
    else if (rnd <43) sItem = "x1_it_spdvscr103";   //Entropic Shield
    else if (rnd <45) sItem = "x1_it_spdvscr104";   //Inflict LW
    else if (rnd <47) sItem = "x1_it_spdvscr105";   //Shield of Faith
    else if (rnd <49) sItem = "x1_it_spdvscr106";   //Magic Fang
    else if (rnd <51) sItem = "x1_it_spdvscr107";   //Camouflage
    else if (rnd <53) sItem = "x1_it_spdvscr101";   //Bane
    else if (rnd <55 )
    { sItem = "x2_it_cfm_bscrl";                   //Blank
      nStack=2;}
    else if (rnd <57) sItem = "x2_it_spdvscr101";
    else if (rnd <59) sItem = "x2_it_sparscr101";   //
    else if (rnd <61) sItem = "x2_it_sparscr102";   //
    else if (rnd <63) sItem = "x2_it_sparscr103";   //
    else if (rnd <65) sItem = "x2_it_sparscr104";   //
    else if (rnd <67) sItem = "x2_it_sparscr105";   //
    }

if (sTreasureSet == "Scrolls12")         //SCROLLS LEVEL 0, 1 & 2
    {
    int counter=0;
    int iNumb=0;
    int rnd2= Random(10)+1;
    if (rnd2<6) counter=1;
    else if (rnd2 <10 ) counter=2;
    else if (rnd2 <11 ) counter=3;
    while (iNumb<counter)
        {
        rnd = Random(117);
        //*****debug line***************
        //SendMessageToPC(GetFirstPC(),"Rolling Magic:  value "+IntToString(rnd));
        if (rnd < 1)
        { sItem = "nw_it_sparscr003";               // Daze
          nStack=2;}
        else if (rnd <2 )
        { sItem = "nw_it_sparscr004";               //Light
          nStack=2;}
        else if (rnd <3 )
        { sItem = "nw_it_sparscr002";               //Ray of Frost
        nStack=2;}
        else if (rnd <4 )
        { sItem = "nw_it_sparscr001";               //Resistance
        nStack=2;}
        else if (rnd <6 ) sItem = "nw_it_sparscr112"; //Burning Hands
        else if (rnd <8 ) sItem = "nw_it_sparscr107"; //Charm Person
        else if (rnd <10 ) sItem = "nw_it_sparscr110"; //Color Spray
        else if (rnd <12 ) sItem = "nw_it_sparscr101"; //Endure Elements
        else if (rnd <14 ) sItem = "nw_it_sparscr103"; //Grease
        else if (rnd <16 ) sItem = "nw_it_sparscr106"; //Identify
        else if (rnd <18 ) sItem = "nw_it_sparscr104"; //Mage armour
        else if (rnd < 20) sItem = "nw_it_sparscr109"; //Magic Missile
        else if (rnd < 22) sItem = "nw_it_sparscr102"; //Protection from Alignment
        else if (rnd < 24) sItem = "nw_it_sparscr111"; //Ray of Enfeeblement
        else if (rnd < 26) sItem = "nw_it_sparscr108"; //Sleep
        else if (rnd < 28) sItem = "nw_it_sparscr105"; //Summon Creature I
        else if (rnd < 29) sItem = "nw_it_sparscr216"; //Knock
        else if (rnd < 30) sItem = "nw_it_sparscr211"; //Blindness / Deafness
        else if (rnd < 31) sItem = "nw_it_sparscr212"; //Bull's Strength
        else if (rnd < 32) sItem = "nw_it_sparscr213"; //Cat's Grace
        else if (rnd < 33) sItem = "nw_it_sparscr217"; //Clarity
        else if (rnd < 34) sItem = "nw_it_sparscr206"; //Darkness
        else if (rnd < 35) sItem = "nw_it_sparscr214"; //Darkvision
        else if (rnd < 36) sItem = "nw_it_sparscr215"; //Endurance
        else if (rnd < 37) sItem = "nw_it_sparscr208"; //Ghostly Visage
        else if (rnd < 38) sItem = "nw_it_sparscr209"; //Ghoul Touch
        else if (rnd < 39) sItem = "nw_it_sparscr207"; //Invisibility
        else if (rnd < 40) sItem = "nw_it_sparscr218"; //Lesser Dispel
        else if (rnd < 41) sItem = "nw_it_sparscr202"; //Melf's Acid Arrow
        else if (rnd < 42) sItem = "nw_it_sparscr201"; //Resist Elements
        else if (rnd < 43) sItem = "nw_it_sparscr210"; //Scare
        else if (rnd < 44) sItem = "nw_it_sparscr205"; //See Invisibility
        else if (rnd < 45) sItem = "nw_it_sparscr203"; //Summon Creature II
        else if (rnd < 46) sItem = "nw_it_sparscr204"; //Web
        else if (rnd <52 ) sItem = "nw_it_spdvscr201"; //snap Lesser Restoration
        else if (rnd <53 ) sItem = "nw_it_spdvscr203"; //snap Silence
        else if (rnd <54 ) sItem = "nw_it_spdvscr204"; //snap Sound Burst
        else if (rnd <55 ) sItem = "nw_it_spdvscr301"; //snap Remove Blindness / Deafness
        else if (rnd <58 ) sItem = "nw_it_spdvscr302"; //snap Remove Disease
        else if (rnd <61 ) sItem = "nw_it_spdvscr402"; //snap Neutralize Poison
   else if (rnd <63 )
    { sItem = "x1_it_sparscr001";                   //
      nStack=2;}
    else if (rnd <65 )
    { sItem = "x1_it_sparscr002";                   //
      nStack=2;}
    else if (rnd <67 )
    { sItem = "x1_it_sparscr003";                   //
      nStack=2;}
    else if (rnd <69 )
    { sItem = "x1_it_spdvscr001";                   //
      nStack=2;}
    else if (rnd <71) sItem = "x1_it_sparscr101";   //Exp. Retreat
    else if (rnd <73) sItem = "x1_it_sparscr102";   //Amplify
    else if (rnd <75) sItem = "x1_it_sparscr103";   //Shield
    else if (rnd <77) sItem = "x1_it_spdvscr102";   //Divine Favour
    else if (rnd <79) sItem = "x1_it_spdvscr103";   //Entropic Shield
    else if (rnd <81) sItem = "x1_it_spdvscr104";   //Inflict LW
    else if (rnd <83) sItem = "x1_it_spdvscr105";   //Shield of Faith
    else if (rnd <85) sItem = "x1_it_spdvscr106";   //Magic Fang
    else if (rnd <87) sItem = "x1_it_spdvscr107";   //Camouflage
    else if (rnd <89) sItem = "x1_it_spdvscr101";   //Bane
    else if (rnd <90) sItem = "x1_it_spdvscr201";   //Inflict MW
    else if (rnd <91) sItem = "x1_it_spdvscr202";   //Blood Frenzy
    else if (rnd <92) sItem = "x1_it_spdvscr203";   //One with the Land
    else if (rnd <93) sItem = "x1_it_spdvscr204";   //Aura of Glory
    else if (rnd <94) sItem = "x1_it_sparscr201";   //Balagorn's
    else if (rnd <95) sItem = "x1_it_sparscr202";   //Tasha's
    else if (rnd <97 )
    { sItem = "x2_it_cfm_bscrl";                   //Blank
      nStack=Random(4)+1;}
    else if (rnd <99) sItem = "x2_it_spdvscr101";
    else if (rnd <101) sItem = "x2_it_sparscr101";   //
    else if (rnd <103) sItem = "x2_it_sparscr102";   //
    else if (rnd <105) sItem = "x2_it_sparscr103";   //
    else if (rnd <107) sItem = "x2_it_sparscr104";   //
    else if (rnd <109) sItem = "x2_it_sparscr105";   //
    else if (rnd <110) sItem = "x2_it_sparscr201";   //
    else if (rnd <111) sItem = "x2_it_sparscr202";   //
    else if (rnd <112) sItem = "x2_it_sparscr203";   //
    else if (rnd <113) sItem = "x2_it_sparscr204";   //
    else if (rnd <114) sItem = "x2_it_sparscr205";   //
    else if (rnd <115) sItem = "x2_it_sparscr206";   //
    else if (rnd <117) sItem = "magicmap";   //  Magic Map
    if (counter-iNumb>1) {CreateItemOnObject(sItem, oCreateIn, nStack);} // All scrolls except last created by this line
        iNumb ++;
    } //End of While Loop
    } //End of Scrolls12 If

if (sTreasureSet == "Scrolls34")         //SCROLLS LEVEL 3 & 4
    {
    int counter=0;
    int iNumb=0;
    int rnd2= Random(10)+1;
    if (rnd2<6) counter=1;
    else if (rnd2 <10 ) counter=2;
    else if (rnd2 <11 ) counter=3;
    while (iNumb<counter)
        {
        rnd = Random(104);
        //*****debug line***************
        //SendMessageToPC(GetFirstPC(),"Rolling Magic:  value "+IntToString(rnd));
        if (rnd < 1) sItem = "nw_it_sparscr307";      //Clairaudience & Clairvoyance
        else if (rnd <4 ) sItem = "nw_it_sparscr301"; //Dispell Magic
        else if (rnd <6 ) sItem = "nw_it_sparscr309"; //Fireball
        else if (rnd <8 ) sItem = "nw_it_sparscr304"; //Flame Arrow
        else if (rnd <10 )sItem = "nw_it_sparscr312"; //Haste
        else if (rnd <12 )sItem = "nw_it_sparscr308"; //Hold Person
        else if (rnd <14 )sItem = "nw_it_sparscr314"; //Invisibility Sphere
        else if (rnd <16 )sItem = "nw_it_sparscr310"; //Lightning Bolt
        else if (rnd <18 )sItem = "nw_it_sparscr302"; //Magic Circle against Alignment
        else if (rnd <20 )sItem = "nw_it_sparscr303"; //Protection from Elements
        else if (rnd <22 )sItem = "nw_it_sparscr313"; //Slow
        else if (rnd <24 )sItem = "nw_it_sparscr305"; //Stinking Cloud
        else if (rnd <26 )sItem = "nw_it_sparscr306"; //Summon Creature III
        else if (rnd <28 )sItem = "nw_it_sparscr311"; //Vampiric Touch
        else if (rnd <30 )sItem = "nw_it_sparscr414"; //Bestow Curse
        else if (rnd <32 )sItem = "nw_it_sparscr405"; //Charm Monster
        else if (rnd <34 )sItem = "nw_it_sparscr406"; //Confusion
        else if (rnd <36 )sItem = "nw_it_sparscr411"; //Contagion
        else if (rnd <38 )sItem = "nw_it_sparscr416"; //Elemental Shield
        else if (rnd <40 )sItem = "nw_it_sparscr412"; //Enervation
        else if (rnd <42 )sItem = "nw_it_sparscr413"; //Fear
        else if (rnd <44 )sItem = "nw_it_sparscr408"; //Improved Invisibility
        else if (rnd <46 )sItem = "nw_it_sparscr417"; //Lesser Spell Breach
        else if (rnd <48 )sItem = "nw_it_sparscr401"; //Minor Globe of Invulnerability
        else if (rnd <50 )sItem = "nw_it_sparscr409"; //Phantasmal Killer
        else if (rnd <52 )sItem = "nw_it_sparscr415"; //Polymorph Self
        else if (rnd <54 )sItem = "nw_it_sparscr402"; //Remove Curse
        else if (rnd <56 )sItem = "nw_it_sparscr410"; //Shadow Conjuration
        else if (rnd <58 )sItem = "nw_it_sparscr403"; //Stoneskin
        else if (rnd <60 )sItem = "nw_it_sparscr404"; //Summon Creature IV
        else if (rnd <62 )sItem = "nw_it_sparscr407"; //Wall of Fire
        else if (rnd <66 )sItem = "x1_it_sparscr301"; //Displace
        else if (rnd <68 )sItem = "x1_it_sparscr302"; //Wounding Whispers
        else if (rnd <70 )sItem = "x1_it_sparscr303"; //Wind
        else if (rnd <72 )sItem = "x1_it_spdvscr301"; //Continual Flame
        else if (rnd <74 )sItem = "x1_it_spdvscr302"; //Inflict SW
        else if (rnd <76 )sItem = "x1_it_spdvscr303"; //G. Magic Fang
        else if (rnd <78 )sItem = "x1_it_spdvscr304"; //Spike Growth
        else if (rnd <80 )sItem = "x1_it_spdvscr305"; //Quillfire
        else if (rnd <82 )sItem = "x1_it_sparscr401"; //Isaac's
        else if (rnd <84 )sItem = "x2_it_spdvscr301"; //
        else if (rnd <86 )sItem = "x2_it_spdvscr302"; //
        else if (rnd <88 )sItem = "x2_it_spdvscr303"; //
        else if (rnd <90 )sItem = "x2_it_spdvscr304"; //
        else if (rnd <92 )sItem = "x2_it_spdvscr305"; //
        else if (rnd <94 )sItem = "x2_it_sparscr301"; //
        else if (rnd <96 )sItem = "x2_it_sparscr302"; //
        else if (rnd <98 )sItem = "x2_it_sparscr303"; //
        else if (rnd <100 )sItem = "x2_it_sparscr304"; //
        else if (rnd <102 )sItem = "x2_it_spdvscr401"; //
        else if (rnd <104 )sItem = "x2_it_spdvscr406"; //
        if (counter-iNumb>1) {CreateItemOnObject(sItem, oCreateIn, nStack);} // All scrolls except last created by this line
        iNumb ++;
    } //End of While Loop
    } //End of Scrolls34 If

if (sTreasureSet == "Scrolls56")         //SCROLLS LEVEL 5 & 6
    {
    int counter=0;
    int iNumb=0;
    int rnd2= Random(10)+1;
    if (rnd2<6) counter=1;
    else if (rnd2 <10 ) counter=2;
    else if (rnd2 <11 ) counter=3;
    while (iNumb<counter)
        {
        rnd = Random(102);
        //*****debug line***************
        //SendMessageToPC(GetFirstPC(),"Rolling Magic:  value "+IntToString(rnd));
        if (rnd < 1) sItem = "nw_it_sparscr501";
        else if (rnd <4 ) sItem = "nw_it_sparscr502";
        else if (rnd <6 ) sItem = "nw_it_sparscr503";
        else if (rnd <8 ) sItem = "nw_it_sparscr504";
        else if (rnd <10 )sItem = "nw_it_sparscr505";
        else if (rnd <12 )sItem = "nw_it_sparscr506";
        else if (rnd <14 )sItem = "nw_it_sparscr507";
        else if (rnd <16 )sItem = "nw_it_sparscr508";
        else if (rnd <18 )sItem = "nw_it_sparscr509";
        else if (rnd <20 )sItem = "nw_it_sparscr510";
        else if (rnd <22 )sItem = "nw_it_sparscr511";
        else if (rnd <24 )sItem = "nw_it_sparscr512";
        else if (rnd <26 )sItem = "nw_it_sparscr513";
        else if (rnd <28 )sItem = "x1_it_sparscr501";
        else if (rnd <30 )sItem = "x1_it_sparscr502";
        else if (rnd <32 )sItem = "x1_it_spdvscr501";
        else if (rnd <34 )sItem = "x1_it_spdvscr502";
        else if (rnd <36 )sItem = "nw_it_sparscr601";
        else if (rnd <38 )sItem = "nw_it_sparscr602";
        else if (rnd <40 )sItem = "nw_it_sparscr603";
        else if (rnd <42 )sItem = "nw_it_sparscr604";
        else if (rnd <44 )sItem = "nw_it_sparscr605";
        else if (rnd <46 )sItem = "nw_it_sparscr606";
        else if (rnd <48 )sItem = "nw_it_sparscr607";
        else if (rnd <50 )sItem = "nw_it_sparscr608";
        else if (rnd <52 )sItem = "nw_it_sparscr609";
        else if (rnd <54 )sItem = "nw_it_sparscr610";
        else if (rnd <56 )sItem = "nw_it_sparscr611";
        else if (rnd <58 )sItem = "nw_it_sparscr612";
        else if (rnd <60 )sItem = "nw_it_sparscr613";
        else if (rnd <62 )sItem = "nw_it_sparscr614";
        else if (rnd <64 )sItem = "x1_it_sparscr601";
        else if (rnd <66 )sItem = "x1_it_sparscr602";
        else if (rnd <68 )sItem = "x1_it_sparscr603";
        else if (rnd <70 )sItem = "x1_it_sparscr604";
        else if (rnd <72 )sItem = "x1_it_sparscr605";
        else if (rnd <74 )sItem = "x1_it_spdvscr601";
        else if (rnd <76 )sItem = "x1_it_spdvscr602";
        else if (rnd <78 )sItem = "x1_it_spdvscr603";
        else if (rnd <80 )sItem = "x1_it_spdvscr604";
        else if (rnd <82 )sItem = "x1_it_spdvscr605";
        else if (rnd <84 )sItem = "x2_it_spdvscr501";
        else if (rnd <86 )sItem = "x2_it_spdvscr502";
        else if (rnd <88 )sItem = "x2_it_spdvscr503";
        else if (rnd <90 )sItem = "x2_it_spdvscr509";
        else if (rnd <92 )sItem = "x2_it_sparscr501";
        else if (rnd <94 )sItem = "x2_it_sparscr502";
        else if (rnd <96 )sItem = "x2_it_spdvscr601";
        else if (rnd <98 )sItem = "x2_it_spdvscr602";
        else if (rnd <100 )sItem = "x2_it_spdvscr606";
        else if (rnd <102 )sItem = "x2_it_sparscr601";
        if (counter-iNumb>1) {CreateItemOnObject(sItem, oCreateIn, nStack);} // All scrolls except last created by this line
        iNumb ++;
    } //End of While Loop
    } //End of Scrolls56 If

if (sTreasureSet == "Weapon1")          //+1 WEAPONS
    {
    rnd = Random(112); // Calculate _one_ random number
        //*****debug line***************
        //SendMessageToPC(GetFirstPC(),"Rolling Magic:  value "+IntToString(rnd));
    if (rnd < 15) sItem = "nw_wswdg002";            //dagger
    else if (rnd < 20) sItem = "nw_wblmhl002";       //light hammer
    else if (rnd < 30) sItem = "nw_wdbmqs002";       //quarterstaff
    else if (rnd < 33) sItem = "nw_waxmhn002";       //hand axe
    else if (rnd < 38) sItem = "nw_waxmbt002";       //battleaxeaxe
    else if (rnd < 44) sItem = "nw_wblmml002";       //light mace
    else if (rnd < 48) sItem = "nw_wblmfl002";       //light flail
    else if (rnd < 52) sItem = "nw_wblmms002";       //morning star
    else if (rnd < 60) sItem = "nw_wswmss002";      //short sword
    else if (rnd < 70) sItem = "nw_wswmls002";       //long sword
    else if (rnd < 73) sItem = "nw_wswmbs002";       //bastard sword
    else if (rnd < 75) sItem = "nw_wswmgs002";       //greatsword
    else if (rnd < 77) sItem = "nw_waxmgr002";       //greataxe
    else if (rnd < 81) sItem = "nw_wplmss002";       //spear
    else if (rnd < 83) sItem = "nw_wplmhb002";       //halberd
    else if (rnd < 84) sItem = "nw_wplmsc002";       //scythe
    else if (rnd < 85) sItem = "nw_wswmka002";       //katana
    else if (rnd < 86) sItem = "nw_wspmku002";       //kukri
    else if (rnd < 88) sItem = "nw_wspmka002";       //kama
    else if (rnd < 91) sItem = "nw_wbwmsh002";       //short bow
    else if (rnd < 93) sItem = "nw_wbwmln002";       //long bow
    else if (rnd < 96) sItem = "nw_wbwmxl002";       //light crossbow
    else if (rnd < 97) sItem = "nw_wbwmxh002";       //heavy crossbow
    else if (rnd < 99) sItem = "nw_wbwmsl002";       //sling
    else if (rnd < 100) sItem = "nw_wblmfh002";      //heavy flail
    else if (rnd < 101) sItem = "nw_wblmhw002";     //warhammer
    else if (rnd < 102) sItem = "nw_wdbmma002";      //Dire Mace
    else if (rnd < 103) sItem = "nw_wdbmax002";      //double axe
    else if (rnd < 104) sItem = "nw_wdbmsw002";      //double sword
//    else if (rnd < 105) sItem = "nw_wspmnn002";      //Nunchaku
    else if (rnd < 106) sItem = "nw_wspmsc002";      //sickle
    else if (rnd < 108) sItem = "nw_wswmmrp002";      //rapier
    else if (rnd < 110) sItem = "nw_wswmsc002";      //scimitar
    else if (rnd < 112) sItem = "x2_it_wpmwhip1";   //whip
    }

if (sTreasureSet == "Weapon2")           //+2 WEAPONS
    {
    rnd = Random(112); // Calculate _one_ random number
        //*****debug line***************
        //SendMessageToPC(GetFirstPC(),"Rolling Magic:  value "+IntToString(rnd));
    if (rnd < 15) sItem = "nw_wswdg008";            //dagger
    else if (rnd < 20) sItem = "nw_wblmhl010";       //light hammer
    else if (rnd < 30) sItem = "nw_wdbmqs008";       //quarterstaff
    else if (rnd < 33) sItem = "nw_waxmhn010";       //hand axe
    else if (rnd < 38) sItem = "nw_waxmbt010";       //battleaxeaxe
    else if (rnd < 44) sItem = "nw_wblmml011";       //light mace
    else if (rnd < 48) sItem = "nw_wblmfl010";       //light flail
    else if (rnd < 52) sItem = "nw_wblmms010";       //morning star
    else if (rnd < 60) sItem = "nw_wswmss009";      //short sword
    else if (rnd < 70) sItem = "nw_wswmls010";       //long sword
    else if (rnd < 73) sItem = "nw_wswmbs009";       //bastard sword
    else if (rnd < 75) sItem = "nw_wswmgs011";       //greatsword
    else if (rnd < 77) sItem = "nw_waxmgr009";       //greataxe
    else if (rnd < 81) sItem = "nw_wplmss010";       //spear
    else if (rnd < 83) sItem = "nw_wplmhb010";       //halberd
    else if (rnd < 84) sItem = "nw_wplmsc010";       //scythe
    else if (rnd < 85) sItem = "nw_wswmka010";       //katana
    else if (rnd < 86) sItem = "nw_wspmku008";       //kukri
    else if (rnd < 88) sItem = "nw_wspmka008";       //kama
    else if (rnd < 91) sItem = "nw_wbwmsh008";       //short bow
    else if (rnd < 93) sItem = "nw_wbwmln008";       //long bow
    else if (rnd < 96) sItem = "nw_wbwmxl008";       //light crossbow
    else if (rnd < 97) sItem = "nw_wbwmxh008";       //heavy crossbow
    else if (rnd < 99) sItem = "nw_wbwmsl009";       //sling
    else if (rnd < 100) sItem = "nw_wblmfh010";      //heavy flail
    else if (rnd < 101) sItem = "nw_wblmhw011";     //warhammer
    else if (rnd < 102) sItem = "nw_wdbmma010";      //Dire Mace
    else if (rnd < 103) sItem = "nw_wdbmax010";      //double axe
    else if (rnd < 104) sItem = "nw_wdbmsw010";      //double sword
//    else if (rnd < 105) sItem = "nw_wspmnn008";      //Nunchaks
    else if (rnd < 106) sItem = "nw_wspmsc010";      //sickle
    else if (rnd < 108) sItem = "nw_wswmrp010";      //rapier
    else if (rnd < 110) sItem = "nw_wswmsc010";      //scimitar
    else if (rnd < 112) sItem = "x2_it_wpmwhip2";   //whip
    }

if (sTreasureSet == "Armour1")           //+1 Armour
    {
    rnd = Random(12); // Calculate _one_ random number
        //*****debug line***************
        //SendMessageToPC(GetFirstPC(),"Rolling Magic:  value "+IntToString(rnd));
    if (rnd < 1) sItem = "nw_maarcl044";            //Leather armour
    else if (rnd <2) sItem = "nw_maarcl043";       //Padded armour
    else if (rnd <3) sItem = "nw_maarcl045";       //Studded Leather armour
//    else if (rnd <4) sItem = "nw_maarcl047";       //Hide armour
    else if (rnd <4) sItem = "hidearmourp1";       //Hide armour (custom)
    else if (rnd <5) sItem = "nw_maarcl046";       //Chain Shirt
    else if (rnd <6) sItem = "nw_maarcl048";       //Scale Mail
    else if (rnd <7) sItem = "nw_maarcl049";       //Breastplate
    else if (rnd <8) sItem = "nw_maarcl035";       //Chain Mail
    else if (rnd <9) sItem = "nw_maarcl051";       //Banded Mail
    else if (rnd <10) sItem = "nw_maarcl050";       //Splint Mail
    else if (rnd <11) sItem = "nw_maarcl052";       //Half Plate
    else if (rnd <12) sItem = "nw_maarcl053";       //Full Plate
    }

if (sTreasureSet == "Armour2")           //+2 Armour
    {
    rnd = Random(12); // Calculate _one_ random number
        //*****debug line***************
        //SendMessageToPC(GetFirstPC(),"Rolling Magic:  value "+IntToString(rnd));
    if (rnd < 1) sItem = "nw_maarcl071";            //Leather armour
    else if (rnd <2) sItem = "nw_maarcl072";       //Padded armour
    else if (rnd <3) sItem = "nw_maarcl075";       //Studded Leather armour
    else if (rnd <4) sItem = "nw_maarcl070";       //Hide armour
    else if (rnd <5) sItem = "nw_maarcl067";       //Chain Shirt
    else if (rnd <6) sItem = "nw_maarcl073";       //Scale Mail
    else if (rnd <7) sItem = "nw_maarcl065";       //Breastplate
    else if (rnd <8) sItem = "nw_maarcl066";       //Chain Mail
    else if (rnd <9) sItem = "nw_maarcl064";       //Banded Mail
    else if (rnd <10) sItem = "nw_maarcl074";       //Splint Mail
    else if (rnd <11) sItem = "nw_maarcl069";       //Half Plate
    else if (rnd <12) sItem = "nw_maarcl068";       //Full Plate
    }


// Major items is a polyglot of various bits of 'nice to have' treasure that can be given out
// without too much worry as to power, and if you are not too fussed about the actual treasure type.
if (sTreasureSet == "Major")           //MAJOR ITEMS
    {
    rnd = Random(94); // Calculate _one_ random number
        //*****debug line***************
        //SendMessageToPC(GetFirstPC(),"Rolling Magic:  value "+IntToString(rnd));
    if (rnd < 7) sItem = "nw_it_mring023";         //Gold Ring
    else if (rnd <12) sItem = "jewelledring";       //Jewelled Ring
    else if (rnd <17) sItem = "nw_it_mneck022";     //Gold Necklace
    else if (rnd <20) sItem = "nw_it_mneck021";     //Silver Necklace
    else if (rnd <23) sItem = "nw_it_mneck023";     //Glittering Necklace
    else if (rnd <24) sItem = "nw_it_mpotion001";   //Cure Light Wounds
    else if (rnd <28) sItem = "nw_it_mpotion002";   //Cure Serious Wounds
    else if (rnd <30) sItem = "nw_it_mpotion006";   //Potion of Antidote
    else if (rnd <33) sItem = "nw_it_mpotion016";   //Potion of Aid
    else if (rnd <36) sItem = "nw_it_mpotion005";   //Potion of Barkskin
    else if (rnd <40) sItem = "nw_it_mpotion009";   //Potion of Bless
    else if (rnd <42) sItem = "nw_it_mpotion011";   //Potion of Lesser Restoration
    else if (rnd <45) sItem = "nw_it_mpotion013";   //Potion of Endurance
    else if (rnd <47) sItem = "nw_it_spdvscr401";   //Restoration
    else if (rnd <49) sItem = "nw_it_mring012";     //Ring of Insight
    else if (rnd <57) sItem = "nw_it_mpotion003"; //Potion of Cure Critical Wounds
    else if (rnd <60) sItem = "nw_it_spdvscr201"; //Lesser Restoration
    else if (rnd <64) sItem = "nw_it_contain003"; //Magic Bag
    else if (rnd <68) sItem = "nw_it_contain004"; //Magic Bag
    else if (rnd <74) sItem = "nw_it_mpotion012"; //Potion of Heal
    else if (rnd <77) sItem = "nw_it_mpotion004"; //Potion of Speed
    else if (rnd <79) sItem = "nw_it_mring013"; //Ring of Scholars
    else if (rnd <81) sItem = "kheotomsointme";//Kheotom's Ointment
    else if (rnd <83) sItem = "nw_it_spdvscr501"; //Raise Dead
    else if (rnd <85) sItem = "nw_it_gem005"; // Diamond
    else if (rnd <87) sItem = "nw_it_gem006"; // Ruby
    else if (rnd <89) sItem = "nw_it_gem008"; //Sapphire
    else if (rnd <91) sItem = "nw_it_gem012"; //Emerald
    else if (rnd <94) sItem = "curseddagger"; //Cursed Dagger
    }//End of MAJOR if


    object oNew = CreateItemOnObject(sItem, oCreateIn, nStack);  // Create the first item
    string sNewObject = GetTag(oNew);//
        //*****debug line***************
        //SendMessageToPC(GetFirstPC(),sTreasureSet+" Item "+sItem+" "+GetName(oNew));


if (nDrop == 1)      SetDroppableFlag(GetObjectByTag(sNewObject),FALSE);
if (nEquip == 1){
    ActionEquipItem(GetObjectByTag(sNewObject),INVENTORY_SLOT_RIGHTHAND);}

}    //End of nChance
}    //End of Void




