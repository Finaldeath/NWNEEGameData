//************************************************************************
// Custom Treasure Function for generating treasure of varying types in placeable, store or creature
// B W-Husey, 30th May 2003
// See cu_magic for the remaining categories (split into two for compile ease)
// Treasure Types included here are:
//  Gold10 - Up to 10 gold, bonus adds to quantity
//    Gold100 - 10d10 Gold, bonus adds to quantity
//    Misc - Various kits, torches, arrows, etc (Containers and Stores)
//    Weapon - standard weapon (no club) (Any, creature arms)
//    Armour - Armour, send a bonus for better stuff (Any, creature armour (I think this only works on prespawned))
//    Gem - Any gem except ruby, diamond, sapphire, emerald (Containers and Creatures)
//    Minor - 1-3 gold, Various gems & non valuable rings, etc. (Containers, stores and some creatures: Bodyguards, etc)
//    OneHand - One handed weapons (more common ones except dagger and club)
//    Ranged - Ranged weapon with 20 amunition
//    AnyHand - Any hand to hand weapon as with OneHand, but includes 2 handed weapons.
//    TwoHand - Two Handed
//Inputs: sTreasureSet - The name of the group of treasure as above
//        oCreateIn    - The object to contain the treasure
//       nChance      - Chance of getting any of this type
//    nBonus  - For Armour (to add in heavier types) by default heavy armours are excluded;
//                Add 4 to add in all heavy and remove light, negative nBonus increases Leather (not padded) chance. Max 4
//                For gold10 & Gold100 (adds to amount)
//      nEquip - 1 = equip the item (use for AnyHand, OneHand)
//      nDrop = Item is not droppable if set to 1
void GetTreasure(string sTreasureSet, object oCreateIn=OBJECT_SELF, int nChance=100, int nBonus=0, int nEquip=0, int nDrop =0);

/*
The following are found in cu_magic and use GetMagic():
    Potions - Potions! (up to 3) (Any)
    Scrolls1 - Level 0 & 1 scrolls (Bookcases, stores & Wizards)
    Scrolls12 - Level 1 & 2 scrolls (Bookcases, stores & Wizards)
    Scrolls34 - level 3 & 4 scrolls (Bookcases, stores & Wizards)
    Weapon1 - +1 weapons (Containers and stores)
    Weapon2 - +2 weapons (Containers and stores)
    Armour1 - +1 Armour (Containers and stores)
    Armour2 - +2 Armour (Containers and stores)
    Major - Various gems (including major), jewelry, chance of minor magic (Containers, stores and some creatures: Bosses)
*/

void GetTreasure(string sTreasureSet, object oCreateIn=OBJECT_SELF, int nChance=100, int nBonus=0, int nEquip=0, int nDrop =0)
{
if (Random(100)<nChance)
{
string sItem = "nw_wswdg001";           //default item = dagger
int nStack=1;                           //default 1 in stack
string sItem2 = "nw_wswdg001";           //default item = dagger
int nStack2=1;                           //default 1 in stack
int rnd;                                //define variables

if (sTreasureSet == "Gold10")           //GOLD 10
    { sItem = "nw_it_gold001";          // 1-10 gold
      nStack=d10()+nBonus;
    }

if (sTreasureSet == "Gold100")           //GOLD 100
    { sItem = "nw_it_gold001";          // 10-100 gold
      nStack=(d10()*10)+nBonus;
    }

if (sTreasureSet == "Misc")             //MISCELLANEOUS
    {
    //*****debug line***************
    //SendMessageToPC(GetFirstPC(),"Rolling Treas:  value "+IntToString(rnd));

    rnd = Random(113);
    if (rnd < 8) sItem = "nw_it_medkit001";             //Healing Kit
    else if (rnd <16 ) sItem = "nw_it_mpotion001";       // Cure Light Wounds
    else if (rnd <22 ) sItem = "nw_wbwsl001";           // Sling
    else if (rnd <24 ) sItem = "nw_it_mpotion002";      // Cure Serious Wounds
    else if (rnd < 28) sItem = "nw_it_torch001";        // Torch
    else if (rnd < 32) sItem = "nw_it_trap001";         // Simple Spike Kit
    else if (rnd < 36){ sItem = "nw_wamar001";          // 20 Arrows
        nStack=20;}
    else if (rnd < 40){ sItem = "nw_wambu001";          // 20 Bullets
        nStack=20;}
    else if (rnd < 44){ sItem = "nw_wambo001";          // 20 bolts
        nStack=20;}
    else if (rnd <48 ) sItem = "nw_it_trap002";         // average spike kit
    else if (rnd < 52) sItem = "nw_it_picks001";        // thieves tools +1
    else if (rnd < 54) sItem = "nw_it_picks002";        // thieves tools +3
    else if (rnd < 56) sItem = "nw_it_mpotion001";      // potion of antidote
    else if (rnd < 62){ sItem = "nw_wthdt001";          // darts
        nStack =10;}
    else if (rnd < 64) sItem = "nw_it_mpotion011";      // Potion of Lesser Restoration
    else if (rnd < 76) sItem = "nw_it_mring021";         //Copper Ring
    else if (rnd < 77) sItem = "x1_it_msmlmisc01";     //Coldstone
    else if (rnd < 78) sItem = "x1_wmgrenade001";     //Acid
    else if (rnd < 79) sItem = "x1_wmgrenade002";     //Fire
    else if (rnd < 80) sItem = "x1_wmgrenade003";     //Caltrops
    else if (rnd < 81) sItem = "x1_wmgrenade004";     //Choking
    else if (rnd < 82) sItem = "x1_wmgrenade005";     //Holy
    else if (rnd < 83) sItem = "x1_wmgrenade006";     //Tangle
    else if (rnd < 84) sItem = "x1_wmgrenade007";     //Thunder
    else if (rnd < 85) sItem = "rope";               //rope
    else if (rnd < 86) sItem = "emptybottle";       //bottle
    else if (rnd < 90) sItem = "nw_it_mring022";     //Silver Ring
    else if (rnd < 91) sItem = "tinderbox";     //Tinder box
    else if (rnd < 92) sItem = "x2_it_cmat_cloth";     //
    else if (rnd < 93) sItem = "x2_it_poison008";
    else if (rnd < 94) sItem = "x2_it_dyeC23";
    else if (rnd < 95) sItem = "x2_it_dyeC02";
    else if (rnd < 96) sItem = "x2_it_amt_feath";
    else if (rnd < 97) sItem = "x2_it_poison015";
    else if (rnd < 98) sItem = "x2_it_dyeL23";
    else if (rnd < 99) sItem = "x2_it_dyeM03";
    else if (rnd < 100) sItem = "x2_it_bmt_proj";
    else if (rnd < 101) sItem = "x2_it_amt_blades";
    else if (rnd < 102) sItem = "x2_it_bmt_cloth";
    else if (rnd < 103) sItem = "x2_it_amt_cpadd";
    else if (rnd < 104) sItem = "x2_it_amt_lpatch";
    else if (rnd < 105) sItem = "x2_it_amt_lstrng";
    else if (rnd < 107) sItem = "bagofsnuff";
    else if (rnd < 109) sItem = "censer";
    else if (rnd < 111) sItem = "hultailspirits";
    else if (rnd < 113) sItem = "silvertradebar";
    }


if (sTreasureSet == "Weapon")           //WEAPONS
    {
    rnd = Random(112); // Calculate _one_ random number
    //*****debug line***************
    //SendMessageToPC(GetFirstPC(),"Rolling Treas:  value "+IntToString(rnd));

    if (rnd < 15) sItem = "nw_wswdg001";            //dagger
    else if (rnd < 20) sItem = "nw_wblhl001";       //light hammer
    else if (rnd < 30) sItem = "nw_wdbqs001";       //quarterstaff
    else if (rnd < 33) sItem = "nw_waxhn001";       //hand axe
    else if (rnd < 38) sItem = "nw_waxbt001";       //battleaxeaxe
    else if (rnd < 44) sItem = "nw_wblml001";       //light mace
    else if (rnd < 48) sItem = "nw_wblfl001";       //light flail
    else if (rnd < 52) sItem = "nw_wblms001";       //morning star
    else if (rnd < 60) sItem = "nw_wswss001";      //short sword
    else if (rnd < 70) sItem = "nw_wswls001";       //long sword
    else if (rnd < 73) sItem = "nw_wswbs001";       //bastard sword
    else if (rnd < 75) sItem = "nw_wswgs001";       //greatsword
    else if (rnd < 77) sItem = "nw_waxgr001";       //greataxe
    else if (rnd < 81) sItem = "nw_wplss001";       //spear
    else if (rnd < 83) sItem = "nw_wplhb001";       //halberd
    else if (rnd < 84) sItem = "nw_wplsc001";       //scythe
    else if (rnd < 85) sItem = "nw_wswka001";       //katana
    else if (rnd < 86) sItem = "nw_wspku001";       //kukri
    else if (rnd < 88) sItem = "nw_wspka001";       //kama
    else if (rnd < 91) sItem = "nw_wbwsh001";       //short bow
    else if (rnd < 93) sItem = "nw_wbwln001";       //long bow
    else if (rnd < 96) sItem = "nw_wbwxl001";       //light crossbow
    else if (rnd < 97) sItem = "nw_wbwxh001";       //heavy crossbow
    else if (rnd < 99) sItem = "nw_wbwsl001";       //sling
    else if (rnd < 100) sItem = "nw_wblfh001";      //heavy flail
    else if (rnd < 101) sItem = "nw_wblhw001";     //warhammer
    else if (rnd < 102) sItem = "nw_wdbma001";      //Dire Mace
    else if (rnd < 103) sItem = "nw_wdbax001";      //double axe
    else if (rnd < 104) sItem = "nw_wdbsw001";      //double sword
    else if (rnd < 105) sItem = "nw_wspnn001";      //Nunchaku
    else if (rnd < 106) sItem = "nw_wspsc001";      //sickle
    else if (rnd < 108) sItem = "nw_wswrp001";      //rapier
    else if (rnd < 110) sItem = "nw_wswsc001";      //scimitar
    else if (rnd < 112) sItem = "x2_it_wpwhip";      //whip
    }

if (sTreasureSet == "Armour")           //Armour
    {
    rnd = Random(8)+nBonus; // Calculate _one_ random number and add bonus
    if (rnd < 1) sItem = "leatherarmour1";            //Leather armour
    else if (rnd <2) sItem = "paddedarmour1";       //Padded armour
    else if (rnd <3) sItem = "studdedleather1";       //Studded Leather armour
    else if (rnd <4) sItem = "hidearmour1";       //Hide armour
    else if (rnd <5) sItem = "chainshirt1";       //Chain Shirt
    else if (rnd <6) sItem = "scalemail1";       //Scale Mail
    else if (rnd <7) sItem = "breastplate1";       //Breastplate
    else if (rnd <8) sItem = "chainmail1";       //Chain Mail
    else if (rnd <9) sItem = "bandedmail1";       //Banded Mail
    else if (rnd <10) sItem = "splintmail2";       //Splint Mail
    else if (rnd <11) sItem = "platemail1";       //Half Plate
    else if (rnd <12) sItem = "fullplate1";       //Full Plate
    }


if (sTreasureSet == "Minor")           //MINOR ITEMS
    {
    rnd = Random(104); // Calculate _one_ random number
    //*****debug line***************
    //SendMessageToPC(GetFirstPC(),"Rolling Treas:  value "+IntToString(rnd));

    if (rnd < 15) sItem = "nw_it_mring021";         //Copper Ring
    else if (rnd <18) sItem = "nw_it_mring022";     //Silver Ring
    else if (rnd <21) sItem = "nw_it_mneck020";     //Copper Necklace
    else if (rnd <23) sItem = "nw_it_mneck021";     //Silver Necklace
    else if (rnd <26) sItem = "nw_it_picks001";     //thieves tools +1
    else if (rnd <29) sItem = "nw_it_picks002";     //thieves tools +3
    else if (rnd <31) sItem = "nw_it_picks003";     //Thieves' Tools +6
    else if (rnd <32) sItem = "nw_it_picks004";     //Thieves' Tools +10
    else if (rnd <36) sItem = "nw_it_medkit001";    //Healing Kit
    else if (rnd <40) sItem = "nw_it_torch001";     //Torch
    else if (rnd <44) sItem = "nw_it_trap001";      //Simple Spike Kit
    else if (rnd <52) sItem = "nw_it_mpotion001";   //Cure Light Wounds
    else if (rnd <57) sItem = "nw_it_mpotion002";   //Cure Serious Wounds
    else if (rnd <60) sItem = "nw_it_mpotion006";   //Potion of Antidote
    else if (rnd <62) sItem = "nw_it_mpotion016";   //Potion of Aid
    else if (rnd <65) sItem = "nw_it_mpotion005";   //Potion of Barkskin
    else if (rnd <68) sItem = "nw_it_mpotion009";   //Potion of Bless
    else if (rnd <71) sItem = "nw_it_mpotion011";   //Potion of Lesser Restoration
    else if (rnd <73) sItem = "nw_it_mpotion013";   //Potion of Endurance
    else if (rnd <74) sItem = "nw_it_mpotion003";   //Potion of Cure Critical Wounds
    else if (rnd <75) sItem = "nw_it_gem002";       //Fire Agate
    else if (rnd <76) sItem = "nw_it_gem003";       //Amethyst
    else if (rnd <77) sItem = "nw_it_gem009";       //Fire Opal
    else if (rnd <78) sItem = "nw_it_gem010";       //Topaz
    else if (rnd <79) sItem = "nw_it_gem013";       //Alexandrite
    else if (rnd <80) sItem = "nw_it_gem014";       //Aventurine
    else if (rnd <82) sItem = "nw_it_gem001";       //Greenstone
    else if (rnd <84) sItem = "nw_it_gem004";       //Phenalope
    else if (rnd <85) sItem = "nw_it_gem007";       //Malachite
    else if (rnd <86) sItem = "nw_it_gem011";       //Garnet
    else if (rnd <87) sItem = "nw_it_gem015";       //Fluorspar
    else if (rnd <88) sItem = "nw_it_spdvscr401";   //Restoration
    else if (rnd <90) sItem = "nw_it_contain002";   //Magic Bag
    else if (rnd <92) sItem = "nw_it_contain001";   //Large Box
    else if (rnd <93) sItem = "nw_it_mring009";     //Ring of Cyan
    else if (rnd <94) sItem = "nw_it_mring010";     //Ring of Crimson
    else if (rnd <95) sItem = "nw_it_mring011";     //Ring of Jade
    else if (rnd <96) sItem = "nw_it_mring012";     //Ring of Insight
    else if (rnd <97)
    { sItem = "darkarrow";                          //Dark Arrows
      nStack= d12();}
    else if (rnd <102) sItem = "x2_it_cfm_pbottl";     //Potion bottle
    else if (rnd <104) sItem = "x2_it_cfm_bscrl";      //Blank Scroll
    } //End of Minor if.

if (sTreasureSet == "Gem")           //MINOR GEMS
    {
    rnd = Random(28); // Calculate _one_ random number
    //*****debug line***************
    //SendMessageToPC(GetFirstPC(),"Rolling Treas:  value "+IntToString(rnd));

    if (rnd < 4) sItem = "nw_it_gem001";            //Greenstone
    else if (rnd <8) sItem = "nw_it_gem004";       //Phenalope
    else if (rnd <11) sItem = "nw_it_gem007";       //Malachite
    else if (rnd <13) sItem = "nw_it_gem011";       //Garnet
    else if (rnd <16) sItem = "nw_it_gem015";       //Fluorspar
    else if (rnd <18) sItem = "nw_it_gem002";       //Fire Agate
    else if (rnd <20) sItem = "nw_it_gem003";       //Amethyst
    else if (rnd <22) sItem = "nw_it_gem009";       //Fire Opal
    else if (rnd <24) sItem = "nw_it_gem010";       //Topaz
    else if (rnd <26) sItem = "nw_it_gem013";       //Alexandrite
    else if (rnd <28) sItem = "nw_it_gem014";       //Aventurine
    }

if (sTreasureSet == "OneHand")           //One handed WEAPONS
    {
    rnd = Random(100); // Calculate _one_ random number
    if (rnd < 5) sItem = "nw_wblhl001";       //light hammer
    else if (rnd < 15) sItem = "nw_waxhn001";       //hand axe
    else if (rnd < 30) sItem = "nw_waxbt001";       //battleaxeaxe
    else if (rnd < 37) sItem = "nw_wblml001";       //light mace
    else if (rnd < 42) sItem = "nw_wblfl001";       //light flail
    else if (rnd < 46) sItem = "nw_wblms001";       //morning star
    else if (rnd < 71) sItem = "nw_wswss001";      //short sword
    else if (rnd < 88) sItem = "nw_wswls001";       //long sword
    else if (rnd < 92) sItem = "nw_wswrp001";      //rapier
    else if (rnd < 100) sItem = "nw_wswsc001";      //scimitar
    }

if (sTreasureSet == "Ranged")           //Ranged WEAPONS
    {
    rnd = Random(100); // Calculate _one_ random number
    if (rnd < 35)
    { sItem = "nw_wbwsh001";       //short bow
      sItem2 = "nw_wamar001";
      nStack2= 20;}
    else if (rnd < 42)
    { sItem = "nw_wbwln001";       //long bow
      sItem2 = "nw_wamar001";
      nStack2= 20;}
    else if (rnd < 65)
    { sItem = "nw_wbwxl001";       //light crossbow
      sItem2 = "nw_wambo001";
      nStack2= 20;}
    else if (rnd < 70)
    { sItem = "nw_wbwxh001";       //heavy crossbow
      sItem2 = "nw_wambo001";
      nStack2= 20;}
    else if (rnd < 100)
    { sItem = "nw_wbwsl001";       //sling
      sItem2 = "nw_wambu001";
      nStack2= 20;}
    CreateItemOnObject(sItem2, oCreateIn,nStack2);            // Create Ammo
    }

if (sTreasureSet == "AnyHand")           //WEAPONS Any Hand
    {
    rnd = Random(100); // Calculate _one_ random number
    if (rnd < 3) sItem = "nw_wblhl001";       //light hammer
    else if (rnd < 6) sItem = "nw_waxhn001";       //hand axe
    else if (rnd < 16) sItem = "nw_waxbt001";       //battleaxeaxe
    else if (rnd < 21) sItem = "nw_wblml001";       //light mace
    else if (rnd < 24) sItem = "nw_wblfl001";       //light flail
    else if (rnd < 27) sItem = "nw_wblms001";       //morning star
    else if (rnd < 33) sItem = "nw_wswss001";      //short sword
    else if (rnd < 48) sItem = "nw_wswls001";       //long sword
    else if (rnd < 51) sItem = "nw_wswbs001";       //bastard sword
    else if (rnd < 56) sItem = "nw_wswgs001";       //greatsword
    else if (rnd < 63) sItem = "nw_waxgr001";       //greataxe
    else if (rnd < 73) sItem = "nw_wplss001";       //spear
    else if (rnd < 79) sItem = "nw_wplhb001";       //halberd
    else if (rnd < 83) sItem = "nw_wplsc001";       //scythe
    else if (rnd < 85) sItem = "nw_wswka001";       //katana
    else if (rnd < 87) sItem = "nw_wblfh001";      //heavy flail
    else if (rnd < 89) sItem = "nw_wblhw001";     //warhammer
    else if (rnd < 90) sItem = "nw_wdbma001";      //Dire Mace
    else if (rnd < 91) sItem = "nw_wdbax001";      //double axe
    else if (rnd < 92) sItem = "nw_wdbsw001";      //double sword
    else if (rnd < 95) sItem = "nw_wswrp001";      //rapier
    else if (rnd < 100) sItem = "nw_wswsc001";      //scimitar
    }

if (sTreasureSet == "TwoHand")           //WEAPONS Two Handed
    {
    rnd = Random(100); // Calculate _one_ random number
    if (rnd < 35) sItem = "nw_wswgs001";       //greatsword
    else if (rnd < 70) sItem = "nw_waxgr001";       //greataxe
    else if (rnd < 79) sItem = "nw_wplhb001";       //halberd
    else if (rnd < 85) sItem = "nw_wplsc001";       //scythe
    else if (rnd < 90) sItem = "nw_wblfh001";      //heavy flail
    else if (rnd < 93) sItem = "nw_wdbma001";      //Dire Mace
    else if (rnd < 97) sItem = "nw_wdbax001";      //double axe
    else if (rnd < 100) sItem = "nw_wdbsw001";      //double sword
    }

    object oNew = CreateItemOnObject(sItem, oCreateIn, nStack);  // Create the first item
    string sNewObject = GetTag(oNew);//
        //*****debug line***************
//        //SendMessageToPC(GetFirstPC(),"Item "+sItem+" "+GetName(oNew));

if (nEquip == 1){
    ActionEquipItem(GetObjectByTag(sNewObject),INVENTORY_SLOT_RIGHTHAND);}
if (nDrop == 1)      SetDroppableFlag(GetObjectByTag(sNewObject),FALSE);
        //*****debug line***************
        //SendMessageToPC(GetFirstPC(),sTreasureSet+" Item "+sItem+" "+GetName(oNew));

}    //End of nChance
}    //End of Void

