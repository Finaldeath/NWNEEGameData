//************************************************************************
// Custom Treasure Function for generating treasure of varying types in placeable, store or creature
// B W-Husey, 24th July 2004
// This version is for weapons with randomised properties
// Treasure Types included here are:
//    Weapon - standard weapon (no club) (Any, creature arms)
//    Armour - Armour, send a bonus for better stuff (Any, creature armour?)
//    OneHand - One handed weapons (more common ones except dagger and club)
//    AnyHand - Any hand to hand weapon as with OneHand, but includes 2 handed weapons.
//Inputs: sTreasureSet - The name of the group of treasure as above
//        oCreateIn    - The object to contain the treasure
//        nChance      - Chance of getting any of this type
//        nBonus  - For Armour (to add in heavier types) by default heavy armours are excluded;
//                  Add 4 to add in all heavy and remove light, negative nBonus increases Leather (not padded) chance. Max 4
//        nEquip - 1 = equip the item (use for AnyHand, OneHand)
//        nPlus = dice bonus size where 1 = +1, 3 = +3 etc.
void GetVariable(string sTreasureSet, object oCreateIn=OBJECT_SELF, int nChance=100, int nBonus=0, int nEquip=0, int nPlus=0);

#include "x2_inc_itemprop"
void GetVariable(string sTreasureSet, object oCreateIn=OBJECT_SELF, int nChance=100, int nBonus=0, int nEquip=0, int nPlus=0)
{
if (Random(100)<nChance)
{
string sItem = "nw_wswdg001";           //default item = dagger
int nStack=1;                           //default 1 in stack
string sItem2 = "nw_wswdg001";           //default item = dagger
int nStack2=1;                           //default 1 in stack
int rnd;                                //define variables
int nSpecial = 0;
// Determine special damage type (weapons)
    int nTYPE = IP_CONST_DAMAGETYPE_SONIC; //default to sonic
    int rndtype = Random(10)+1;
     if (rndtype==1) {      nTYPE = IP_CONST_DAMAGETYPE_SONIC;     }
     if (rndtype==2) {      nTYPE = IP_CONST_DAMAGETYPE_ACID;     }
     if (rndtype==3) {      nTYPE = IP_CONST_DAMAGETYPE_COLD;     }
     if (rndtype==4) {      nTYPE = IP_CONST_DAMAGETYPE_DIVINE;     }
     if (rndtype==5) {      nTYPE = IP_CONST_DAMAGETYPE_ELECTRICAL;     }
     if (rndtype==6) {      nTYPE = IP_CONST_DAMAGETYPE_FIRE;     }
     if (rndtype==7) {      nTYPE = IP_CONST_DAMAGETYPE_NEGATIVE;
            nSpecial = IP_CONST_ALIGNMENTGROUP_EVIL;}
     if (rndtype==8) {      nTYPE = IP_CONST_DAMAGETYPE_POSITIVE;
            nSpecial = IP_CONST_ALIGNMENTGROUP_GOOD;}
            //9 is keen, no constant
     if (rndtype==10) {      nTYPE = IP_CONST_DAMAGETYPE_ELECTRICAL;     }

    //*************Debug line***************
//    SendMessageToPC(GetFirstPC(),"Variable throw: "+IntToString(rndtype));

// Determine special armour type (armour)
   int nATYPE = 0; //
    int rndtypeb = Random(14)+1;
     if (rndtypeb<4) {      nATYPE = IP_CONST_DAMAGETYPE_BLUDGEONING;     }
    else if (rndtypeb<7) {      nATYPE = IP_CONST_DAMAGETYPE_PIERCING;     }
    else if (rndtypeb<10) {      nATYPE = IP_CONST_DAMAGETYPE_SLASHING;}
    else if (rndtypeb==10) {      nATYPE = IP_CONST_SAVEBASETYPE_FORTITUDE;}
    else if (rndtypeb==11) {      nATYPE = IP_CONST_SAVEBASETYPE_REFLEX;}
    else if (rndtypeb==12) {      nATYPE = IP_CONST_SAVEBASETYPE_WILL;}
    else if (rndtypeb==13) {      nATYPE = SKILL_DISCIPLINE;}
    else if (rndtypeb==14) {      nATYPE = SKILL_TUMBLE;}

if (sTreasureSet == "Weapon")           //WEAPONS
    {
    rnd = Random(112); // Calculate _one_ random number
    if (rnd < 15) sItem = "magicdagger";            //dagger
    else if (rnd < 20) sItem = "magichammer";       //light hammer
    else if (rnd < 30) sItem = "magicstaff";       //quarterstaff
    else if (rnd < 33) sItem = "magichandaxe";       //hand axe
    else if (rnd < 38) sItem = "magicaxe";       //battleaxeaxe
    else if (rnd < 44) sItem = "magicmace";       //light mace
    else if (rnd < 48) sItem = "magichorseflail";       //light flail
    else if (rnd < 52) sItem = "magicmorningstar";       //morning star
    else if (rnd < 60) sItem = "magicshortsword";      //short sword
    else if (rnd < 70) sItem = "magiclongsword";       //long sword
    else if (rnd < 73) sItem = "magicbsword";       //bastard sword
    else if (rnd < 75) sItem = "magicsword";       //greatsword
    else if (rnd < 77) sItem = "magicgreataxe";       //greataxe
    else if (rnd < 81) sItem = "magicspear";       //spear
    else if (rnd < 83) sItem = "magicpoleaxe";       //halberd
    else if (rnd < 84) sItem = "magicscythe";       //scythe
    else if (rnd < 85) sItem = "magicclaymore";       //katana
    else if (rnd < 86) sItem = "magickukri";       //kukri
    else if (rnd < 88) sItem = "magickama";       //kama
    else if (rnd < 95) { sItem = "magicdart";       //magic dart
    nStack = d6()+4;}
    else if (rnd < 98) { sItem = "magicthrowingaxe";       //magic throwing axe
    nStack = d6()+4;}
    else if (rnd < 99) { sItem = "magicshuriken";       //magic shuriken
    nStack = d12()+4;}
    else if (rnd < 100) sItem = "magicfootflail";      //heavy flail
    else if (rnd < 101) sItem = "magicwarhammer";     //warhammer
    else if (rnd < 102) sItem = "magicdiremace";      //Dire Mace
    else if (rnd < 103) sItem = "magicdoubleaxe";      //double axe
    else if (rnd < 104) sItem = "magicdoublesword";      //double sword
    else if (rnd < 106) sItem = "magicsickle";      //sickle
    else if (rnd < 108) sItem = "magicrapier";      //rapier
    else if (rnd < 110) sItem = "magictulwar";      //scimitar
    else if (rnd < 110) sItem = "magicwhip";      //whip
    }

if (sTreasureSet == "Armour")           //Armour
    {
    rnd = Random(8)+nBonus; // Calculate _one_ random number and add bonus
    if (rnd < 1) sItem = "leatherarmourv";            //Leather armour
    else if (rnd <2) sItem = "paddedarmourv";       //Padded armour
    else if (rnd <3) sItem = "studdedleatherv";       //Studded Leather armour
    else if (rnd <4) sItem = "hidearmourv";       //Hide armour
    else if (rnd <5) sItem = "chainshirtv";       //Chain Shirt
    else if (rnd <6) sItem = "scalemailv";       //Scale Mail
    else if (rnd <7) sItem = "breastplatev";       //Breastplate
    else if (rnd <8) sItem = "chainmailv";       //Chain Mail
    else if (rnd <9) sItem = "bandedmailv";       //Banded Mail
    else if (rnd <10) sItem = "splintmailv";       //Splint Mail
    else if (rnd <11) sItem = "platemailv";       //Half Plate
    else if (rnd <12) sItem = "fullplatev";       //Full Plate
    }


if (sTreasureSet == "AnyHand")           //WEAPONS Any Hand
    {
    rnd = Random(100); // Calculate _one_ random number
    if (rnd < 3) sItem = "magichammer";       //light hammer
    else if (rnd < 6) sItem = "magichandaxe";       //hand axe
    else if (rnd < 16) sItem = "magicaxe";       //battleaxeaxe
    else if (rnd < 21) sItem = "magicmace";       //light mace
    else if (rnd < 24) sItem = "magichorseflail";       //light flail
    else if (rnd < 27) sItem = "magicmorningstar";       //morning star
    else if (rnd < 33) sItem = "magicshortsword";      //short sword
    else if (rnd < 48) sItem = "magiclongsword";       //long sword
    else if (rnd < 51) sItem = "magicbsword";       //bastard sword
    else if (rnd < 56) sItem = "magicsword";       //greatsword
    else if (rnd < 63) sItem = "magicgreataxe";       //greataxe
    else if (rnd < 73) sItem = "magicspear";       //spear
    else if (rnd < 79) sItem = "magicpoleaxe";       //halberd
    else if (rnd < 83) sItem = "magicscythe";       //scythe
    else if (rnd < 85) sItem = "magicclaymore";       //katana
    else if (rnd < 87) sItem = "magicfootflail";      //heavy flail
    else if (rnd < 89) sItem = "magicwarhammer";     //warhammer
    else if (rnd < 90) sItem = "magicdiremace";      //Dire Mace
    else if (rnd < 91) sItem = "magicdoubleaxe";      //double axe
    else if (rnd < 92) sItem = "magicdoublesword";      //double sword
    else if (rnd < 95) sItem = "magicrapier";      //rapier
    else if (rnd < 100) sItem = "magictulwar";      //scimitar
    }

if (sTreasureSet == "OneHand")           //One handed WEAPONS
    {
    rnd = Random(100); // Calculate _one_ random number
    if (rnd < 5) sItem = "magichammer";       //light hammer
    else if (rnd < 15) sItem = "magichandaxe";       //hand axe
    else if (rnd < 30) sItem = "magicaxe";       //battleaxeaxe
    else if (rnd < 37) sItem = "magicmace";       //light mace
    else if (rnd < 42) sItem = "magichorseflail";       //light flail
    else if (rnd < 46) sItem = "magicmorningstar";       //morning star
    else if (rnd < 71) sItem = "magicshortsword";      //short sword
    else if (rnd < 88) sItem = "magiclongsword";       //long sword
    else if (rnd < 92) sItem = "magicrapier";      //rapier
    else if (rnd < 100) sItem = "magictulwar";      //scimitar
    }

object oNew = CreateItemOnObject(sItem, oCreateIn,nStack);// Create the item
string sNewObject = GetTag(oNew);
    //ARMOUR - check what type of bonus is being added (rndtypeb), then add it
   if (nPlus>0 && GetBaseItemType(oNew)==BASE_ITEM_ARMOR) {
        if (rndtypeb>12){
        IPSafeAddItemProperty(oNew,ItemPropertySkillBonus(nATYPE,nPlus*2),0.0,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
        IPDyeArmor( oNew, ITEM_APPR_ARMOR_COLOR_CLOTH1, Random(64) );
//        IPDyeArmor( oNew, ITEM_APPR_ARMOR_COLOR_CLOTH2, Random(64) );
        }
        else if (rndtypeb>9){
        IPSafeAddItemProperty(oNew,ItemPropertyBonusSavingThrow(nATYPE,nPlus),0.0,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
        IPSafeAddItemProperty(oNew,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_80_PERCENT),0.0,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
        IPDyeArmor( oNew, ITEM_APPR_ARMOR_COLOR_CLOTH1, Random(64) );
//        IPDyeArmor( oNew, ITEM_APPR_ARMOR_COLOR_CLOTH2, Random(64) );
        }
        else if (rndtypeb<10){
        IPSafeAddItemProperty(oNew,ItemPropertyACBonusVsDmgType(nATYPE,nPlus),0.0,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
        IPDyeArmor( oNew, ITEM_APPR_ARMOR_COLOR_CLOTH1, Random(64) );
//        IPDyeArmor( oNew, ITEM_APPR_ARMOR_COLOR_CLOTH2, Random(64) );
        }
    }
    //WEAPONS - check what type of bonus is being added (rndtype), then add it
   else if (nPlus>0) {
    if  (rndtype==9)
    {
        IPSafeAddItemProperty(oNew,ItemPropertyKeen(),0.0,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
    }
    if  (rndtype==10)
    {
        IPSafeAddItemProperty(oNew,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM,IP_CONST_LIGHTCOLOR_GREEN),0.0,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
    }
    else
    {
        if (nSpecial>0) {    IPSafeAddItemProperty(oNew,ItemPropertyLimitUseByAlign(nSpecial),0.0,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);}
        IPSafeAddItemProperty(oNew,ItemPropertyDamageBonus(nTYPE,nPlus),0.0,X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
    }
    }

if (nEquip == 1){
    ActionEquipItem(GetObjectByTag(sNewObject),INVENTORY_SLOT_RIGHTHAND);}
}    //End of nChance
}    //End of Void

