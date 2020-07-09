// December 2005
// B W-husey
// This script equips the calling object with basic woodsman items dependant on class
// Last Modified By: Syrsnein 13 June 2006


void DLA_CreateItemFailSafe(object oPC,string sRes,string sTag,int nStack);

void main()
{
    object oPC = OBJECT_SELF;
    //******debug lines********
//    string sDebug = GetName(oPC);
//    SendMessageToPC(oPC,"Running on "+sDebug);
    //Give the PC some gold & equipment
        int STARTING_GOLD = 5+d6(3);
             object oAmmo;
            int nStackSize = 40;
            //Weapons
            if (GetRacialType(oPC)==RACIAL_TYPE_ELF)
                CreateItemOnObject("nw_wswls001",oPC); //longsword
            else if (GetClassByPosition(1,oPC)==CLASS_TYPE_CLERIC
                || GetClassByPosition(1,oPC)==CLASS_TYPE_SORCERER
                || GetClassByPosition(1,oPC)==CLASS_TYPE_BARD
                || GetClassByPosition(1,oPC)==CLASS_TYPE_DRUID)
                CreateItemOnObject("nw_wplss001",oPC); //spear
            else if (GetClassByPosition(1,oPC)==CLASS_TYPE_WIZARD)
                STARTING_GOLD = STARTING_GOLD + 40;    //extra gold
            else
                CreateItemOnObject("nw_waxhn001",oPC);//handaxe

            //Ranged weapon
            if (GetRacialType(oPC)==RACIAL_TYPE_ELF
                || GetClassByPosition(1,oPC)==CLASS_TYPE_FIGHTER
                || GetClassByPosition(1,oPC)==CLASS_TYPE_RANGER
                || GetClassByPosition(1,oPC)==CLASS_TYPE_BARBARIAN
                || GetClassByPosition(1,oPC)==CLASS_TYPE_PALADIN)
                {
                CreateItemOnObject("nw_wbwsh001",oPC); //shortbow
                //oAmmo = CreateItemOnObject("nw_wamar001",oPC); // arrows
                DLA_CreateItemFailSafe(oPC,"nw_wamar001","NW_WAMAR001",nStackSize);
                //SetItemStackSize(oAmmo,nStackSize);
                //AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_ARROWS));
                }
            else if (GetClassByPosition(1,oPC)==CLASS_TYPE_DRUID)
                {
                CreateItemOnObject("nw_wbwsl001",oPC); //sling
                //oAmmo = CreateItemOnObject("nw_wambu001",oPC); // arrows
                DLA_CreateItemFailSafe(oPC,"nw_wambu001","NW_WAMBU001",nStackSize);
                //SetItemStackSize(oAmmo,nStackSize);
                //AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BULLETS));
                }
            else
                {
                CreateItemOnObject("nw_wbwxl001",oPC); //Light xbow
                //oAmmo = CreateItemOnObject("nw_wambo001",oPC); //
                DLA_CreateItemFailSafe(oPC,"nw_wambo001","NW_WAMBO001",nStackSize);
                //SetItemStackSize(oAmmo,nStackSize);
                //AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BOLTS));
                }
            // Armour
            object oArmour;
            if (GetClassByPosition(1,oPC)==CLASS_TYPE_MONK
                || GetClassByPosition(1,oPC)==CLASS_TYPE_SORCERER
                || GetClassByPosition(1,oPC)==CLASS_TYPE_WIZARD)
                oArmour = CreateItemOnObject("nw_cloth001",oPC); //clothes
            else
                oArmour = CreateItemOnObject("nw_aarcl001",oPC); //leather
        //Items that everyone gets
        CreateItemOnObject("nw_it_mpotion001",oPC,1);
        CreateItemOnObject("nw_it_mpotion001",oPC,1);
        CreateItemOnObject("nw_wswdg001",oPC);//dagger
//        CreateItemOnObject("dla_it_debugdump",oPC); // debug tool remove after beta
        GiveGoldToCreature(oPC, STARTING_GOLD);
        // Move stuff to where the player can see it!
        ActionEquipItem(oArmour,INVENTORY_SLOT_CHEST);
// Removed these commands so the player doesn't have anything in their hands at
// the start of the game (looks silly having his weapon sticking through his
// forhead during parts of the opening dialogue.
//        AssignCommand(oPC,ActionEquipMostEffectiveArmor());
//        AssignCommand(oPC,ActionEquipMostDamagingRanged());
//        AssignCommand(oPC,ActionEquipMostDamagingMelee());
}


void DLA_CreateItemFailSafe(object oPC,string sRes,string sTag,int nStack)
{ // PURPOSE: To supply bullets, arrows, or bolts as appropriate
  // Original Scripter:  Deva Winblood
  // Last Modified By:   Deva Winblood   5/15/2006
  object oItem=GetItemPossessedBy(oPC,sTag);
  int nStackSize=nStack;
  if (oItem==OBJECT_INVALID)
  { // create item
    oItem=CreateItemOnObject(sRes,oPC,nStack);
    DelayCommand(1.0,DLA_CreateItemFailSafe(oPC,sRes,sTag,nStack)); // fail safe
  } // create item
  else
  { // item exists
    if (nStackSize<1) nStackSize=1;
    SetItemStackSize(oItem,nStack);
  } // item exists
} // DLA_EquipAmmo()
