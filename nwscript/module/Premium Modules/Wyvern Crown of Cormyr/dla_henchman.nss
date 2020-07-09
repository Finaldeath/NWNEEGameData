// My henchman routines: adapted from tm_henchlib
///
// Written by: Celowin
// Last updated: 7/25/02
// Modified by B W-Husey (B G P Hughes)

#include "x0_i0_common"
#include "nw_i0_plot"
#include "nw_i0_generic"

int GetTargetLevel(object oHench = OBJECT_SELF)
{

// Find the PC's level.
  int nMasterLevel = GetHitDice(GetMaster(oHench));
    int HENCH_MIN;
    int HENCH_MAX;
    int HENCH_LAG;

// Find the desired level.
// This function figures out what level the henchman
// "should" be, based on the min, max, and lag
// numbers above, as well as the PC level.


  int nTargetLevel = nMasterLevel-HENCH_LAG;

  // If that is less than the minimum level, the
  // henchman should be that minimum level.
  if (nTargetLevel < HENCH_MIN)
    nTargetLevel = HENCH_MIN;
  // If the level is over the max, cap the level
  // to that max.
  if (nTargetLevel > HENCH_MAX)
    nTargetLevel = HENCH_MAX;
    object obPC =  GetMaster(oHench);
//    FloatingTextStringOnCreature("Master"+IntToString(nMasterLevel),obPC);
//    FloatingTextStringOnCreature("Hench Actual"+IntToString(nTargetLevel),obPC);
//    FloatingTextStringOnCreature("LAG"+IntToString(HENCH_LAG),obPC);
  return nTargetLevel;
}

// This function checks to see if the henchman
// is ready to level up.
int GetReadyToLevel(object oHench = OBJECT_SELF)
{
  // Find both the current henchman level, and
  // what level the henchman should be.
  int nTargetLevel = GetTargetLevel(oHench);
  int nCurrentLevel = GetHitDice(oHench);

  // If the current level is too low, it is ready
  // to level up.
  if (nCurrentLevel < nTargetLevel)
    return TRUE;
  else
    return FALSE;
}



//                             REMOVED
//============================================================================
// This is the biggie.  This is the function to
// actually level up the henchman.
/*

void LevelHench(object oHench = OBJECT_SELF)
{


  int nTargetLevel = GetTargetLevel(oHench);

  // Whee!  Fun with string manipulation!
  // All this is working to find the appropriate blueprint ResRef
  // to create the "new and improved" henchman.
  string sNewBlueprint = GetTag(oHench);
  sNewBlueprint = GetStringLowerCase(sNewBlueprint);
  if (nTargetLevel <= 9)
    sNewBlueprint = sNewBlueprint + "0";
  sNewBlueprint = sNewBlueprint + IntToString(nTargetLevel);

  // Create the new henchman.
  // There will be a "fade in" of the new one and a "fade out"
  // of the old.
  object oNewHench = CreateObject(OBJECT_TYPE_CREATURE, sNewBlueprint, GetLocation(oHench));

  // Get rid of the old henchman.  You're fired!
  object oMaster = GetMaster(oHench);
  RemoveHenchman(oMaster, oHench);

  // Copy our desired behavior patterns to the new henchman.
  CopyLocals(oHench, oNewHench);
  AssignCommand(oNewHench,SetAssociateListenPatterns());

  // Add in our new henchman.
  AddHenchman(oMaster,oNewHench);

  // Take out the trash.
  DestroyObject(oHench);
}
*/
/**** LEVELING UP ****/

// Store all items in the henchman's inventory in the campaign DB,
// skipping those items which have the henchman's tag in their
// name.
// This is paired with RetrieveHenchmanItems for the leveling-up
// process.
void StoreHenchmanItems(object oPC, object oHench);
void StoreItems(object oPC, object oHench);

// Retrieve (and then delete) all henchman inventory items out of
// the campaign DB, putting them in the inventory of the henchman.
// This is paired with StoreHenchmanItems for the leveling-up
// process.
void RetrieveHenchmanItems(object oPC, object oHench);
// levels up the henchman assigned to oPC
void LevelUpXP1Henchman(object oPC);

/**** LEVELING UP ****/


// Store all items in the henchman's inventory in the campaign DB.
void StoreHenchmanItems(object oPC, object oHench)
{
    string sHenchTag = GetTag(oHench);

    string sTag;
    object oItem;
    int nNth = 0;
    string sItemName; string sVarname;

    // Mark and store equipped items
    int i;
    for (i=0; i < NUM_INVENTORY_SLOTS; i++) {
        oItem = GetItemInSlot(i, oHench);
        if (GetIsObjectValid(oItem)) {
            sItemName = GetTag(oItem);
            DBG_msg("Found equipped item " + sItemName);

            // store the slot number + 1 so when we
            // retrieve a 0 can be treated as unequipped
            SetLocalInt(oPC, "HENCH_HAS_EQUIPPED_" + sItemName, i+1);

            if (FindSubString(sItemName, sHenchTag) == -1) {
                // put it in the db
                sVarname = sHenchTag + "_ITEM_" + IntToString(nNth);
                DBG_msg("Storing equipped item: " + sItemName
                        + ", varname " + sVarname);
                nNth++;
                StoreCampaignDBObject(oPC, sVarname, oItem);

            }
        }
    }

    oItem = GetFirstItemInInventory(oHench);
    while (GetIsObjectValid(oItem)) {
        sItemName = GetTag(oItem);
        DBG_msg("Found item " + sItemName);
        if (FindSubString(sItemName, sHenchTag) == -1) {
            // put it in the db
            sVarname = sHenchTag + "_ITEM_" + IntToString(nNth);
            DBG_msg("Storing item: " + sItemName + ", varname " + sVarname);
            nNth++;
          StoreCampaignDBObject(oPC, sVarname, oItem);
        }
        oItem = GetNextItemInInventory(oHench);
    }
}

void StoreItems(object oPC, object oHench)
{
object oEqItem;
oEqItem=GetItemInSlot(INVENTORY_SLOT_ARMS);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));
oEqItem=GetItemInSlot(INVENTORY_SLOT_ARROWS);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));
oEqItem=GetItemInSlot(INVENTORY_SLOT_BELT);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));
oEqItem=GetItemInSlot(INVENTORY_SLOT_BOLTS);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));
oEqItem=GetItemInSlot(INVENTORY_SLOT_BOOTS);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));
oEqItem=GetItemInSlot(INVENTORY_SLOT_BULLETS);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));
oEqItem=GetItemInSlot(INVENTORY_SLOT_CARMOUR);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));
oEqItem=GetItemInSlot(INVENTORY_SLOT_CHEST);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));
oEqItem=GetItemInSlot(INVENTORY_SLOT_CLOAK);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));
oEqItem=GetItemInSlot(INVENTORY_SLOT_CWEAPON_B);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));
oEqItem=GetItemInSlot(INVENTORY_SLOT_CWEAPON_L);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));
oEqItem=GetItemInSlot(INVENTORY_SLOT_CWEAPON_R);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));
oEqItem=GetItemInSlot(INVENTORY_SLOT_HEAD);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));
oEqItem=GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));
oEqItem=GetItemInSlot(INVENTORY_SLOT_LEFTRING);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));
oEqItem=GetItemInSlot(INVENTORY_SLOT_NECK);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));
oEqItem=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));
oEqItem=GetItemInSlot(INVENTORY_SLOT_RIGHTRING);
CopyItem(oEqItem,GetNearestObjectByTag("Holder"));

    string sItemName;
    object oItem = GetFirstItemInInventory(oHench);
    while (GetIsObjectValid(oItem)) {
      CopyItem(oItem,GetNearestObjectByTag("Holder"));
      DestroyObject(oItem);
//        CreateItemOnObject(GetResRef(oItem),GetNearestObjectByTag("Holder"));
        oItem = GetNextItemInInventory(oHench);
    }
}

// Retrieve (and then delete) all henchman inventory items out of
// the campaign DB, putting them in the inventory of the henchman.
void RetrieveHenchmanItems(object oPC, object oHench)
{
    location lHench  = GetLocation(oHench);
    string sHenchTag = GetTag(oHench);
    int nNth = 0; int nSlot = -1;
    object oCurItem = OBJECT_INVALID;

    string sVarname = sHenchTag + "_ITEM_0";

    object oItem = RetrieveCampaignDBObject(oPC, sVarname, lHench, oHench);
    string sItemName = GetTag(oItem);

    DBG_msg("Retrieving item " + sItemName + ", varname: " + sVarname);
    while (GetIsObjectValid(oItem)) {
        DeleteCampaignDBVariable(oPC, sVarname);
        nNth++;
        sVarname = sHenchTag + "_ITEM_" + IntToString(nNth);
        oItem = RetrieveCampaignDBObject(oPC, sVarname, lHench, oHench);
        sItemName = GetTag(oItem);
        DBG_msg("Retrieving item " + sItemName + ", varname: " + sVarname);
    }

    // Now run through inventory and restore equipped items
    oItem = GetFirstItemInInventory(oHench);
    while (GetIsObjectValid(oItem)) {
        sItemName = GetTag(oItem);

        // Above, we stored the slot + 1 so we could treat a 0
        // as meaning "not equipped".
        nSlot = GetLocalInt(oPC, "HENCH_HAS_EQUIPPED_" + sItemName) - 1;
        if (nSlot != -1) {
            DBG_msg("Item was equipped in slot " + IntToString(nSlot));
            DeleteLocalInt(oPC, "HENCH_HAS_EQUIPPED_" + sItemName);
            oCurItem = GetItemInSlot(nSlot, oHench);
            if (GetIsObjectValid(oCurItem)) {
                AssignCommand(oHench, ActionUnequipItem(oCurItem));
            }
            AssignCommand(oHench, ActionEquipItem(oItem, nSlot));
        }
        oItem = GetNextItemInInventory(oHench);
    }
}

void RetrieveItems(object oPC, object oHench)
{
    string sItemName;
    object oHold = GetNearestObjectByTag("Holder");
    object oItem = GetFirstItemInInventory(oHold);
    while (GetIsObjectValid(oItem)) {
        sItemName = GetTag(oItem);
        CopyItem(oItem,oHench);
        DestroyObject(oItem);
//        CreateItemOnObject(GetResRef(oItem),oHench);
        oItem = GetNextItemInInventory(oHold);
    }
    ActionEquipMostEffectiveArmor();
}

void SetBeenHired(int bHired=TRUE, object oTarget=OBJECT_SELF)
{
    SetLocalInt(oTarget,"NW_L_HENHIRED",10);
}
int GetBeenHired(object oTarget=OBJECT_SELF)
{
    return GetLocalInt(oTarget,"NW_L_HENHIRED") == 10;
}
//::///////////////////////////////////////////////
//:: CopyLocals
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Copies locals from the 'earlier'
    level henchmen to the newer henchman.
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent
//:: Created On:
//:://////////////////////////////////////////////
void CopyLocals(object oSource, object oTarget)
{
  SetBeenHired(GetBeenHired(oSource), oTarget);
  SetLocalInt(oTarget, "NW_ASSOCIATE_MASTER", GetLocalInt(oSource, "NW_ASSOCIATE_MASTER"));
//  AssignCommand(PC(),SpeakString(IntToString(GetLocalInt(oSource, "NW_ASSOCIATE_MASTER"))));
//  AssignCommand(PC(),SpeakString(IntToString(GetLocalInt(oTarget, "NW_ASSOCIATE_MASTER"))));


}
// * assumes that a succesful GetCanLevelUp has already
// * been tested.    Will level up character to one level
// * less than player.
// * meLevel defaults to object self unless another object is passed in
// * returns the new creature

//=========================================================
//============================================================
object DoLevelUp(object oPC, object MeLevel = OBJECT_SELF)
{
   object oHench = OBJECT_SELF;
   int nMasterLevel = GetHitDice(oPC);
   int nLevel = GetTargetLevel(oHench);

   // * Copy variables to the PC for 'safekeeping'
   CopyLocals(MeLevel, oPC);

   // * if already the highest level henchmen
   // * then do nothing.
   if (GetHitDice(MeLevel) >= nLevel)//modified
   {
    return OBJECT_INVALID;
   }

   string sLevel = IntToString(nLevel);
   // * add a 0 if necessary
   if (GetStringLength(sLevel) == 1)
   {
    sLevel = "0" + sLevel;
   }
   object oMaster = GetMaster(MeLevel);
   object oHold = CreateObject(OBJECT_TYPE_PLACEABLE, "holder", GetLocation(MeLevel), FALSE, "Holder");//NEW
   StoreItems(oPC, MeLevel);
   RemoveHenchman(oMaster, MeLevel);
//   string sNewFile = GetTag(MeLevel) + "_" + sLevel;
   string sNewFile = GetTag(MeLevel) + sLevel;
   AssignCommand(MeLevel, ClearAllActions());
   AssignCommand(MeLevel, PlayAnimation(ANIMATION_LOOPING_MEDITATE));
//   SpeakString(sNewFile);
   object oNew = CreateObject(OBJECT_TYPE_CREATURE, sNewFile, GetLocation(MeLevel), FALSE);
   RetrieveItems(oPC, oNew);

   AssignCommand(MeLevel, AddHenchman(oMaster, oNew));
   DestroyObject(oHold, 0.5);
   DestroyObject(MeLevel, 0.5);
   DelayCommand(0.4, CopyLocals(oPC, oNew));
   return oNew;

}

//Not used due to henchman lags
/*
void LevelHenchmanUpTo(object oHenchman, int nLevel, int nClass2=CLASS_TYPE_INVALID, int nMaxLevelInSecondClass=0)
{
    if ( !GetIsObjectValid(oHenchman) || GetHitDice(oHenchman) >= nLevel)
        return;

    int nClass1 = GetClassByPosition(1, oHenchman);
    if (nClass2 == CLASS_TYPE_INVALID) {
        nClass2 = GetClassByPosition(2, oHenchman);
    }

    int nLevel1 = GetLevelByClass(nClass1, oHenchman);
    int nLevel2 = GetLevelByClass(nClass2, oHenchman);

    int nClassToLevelUp;

    while ( (nLevel1 + nLevel2) < nLevel )
    {
        if ( nClass2 != CLASS_TYPE_INVALID && (nLevel1 > nLevel2) )
        {
            nClassToLevelUp = nClass2;
            nLevel2++;
        }
        else
        {
            nClassToLevelUp = nClass1;
            nLevel1++;
        }

        // * if you have exceeded your max level in the second class
        // * only level up in the first class from this point forward
        if (nLevel2 > nMaxLevelInSecondClass)
        {
            nClassToLevelUp = nClass1;
        }

        // * Additional Rules
        // * The player can choose a levelup stratedgy for the henchman
        // * 0 = Normal, as per designer rules
        // * 1 = Secondary Class: only take levels in your second class
        // * 2 = First class: only take levels in your first class
        // * Note: This choice overrides the above nMaxLevelInSecondClass
        int nRule = GetLocalInt(oHenchman, "X0_L_LEVELRULES");
        if (nRule == 1)
        {
            nClassToLevelUp = nClass2;
        }
        else
        if (nRule == 2)
        {
            nClassToLevelUp = nClass1;
        }
        if (! LevelUpHenchman(oHenchman, nClassToLevelUp))
        {
            SendMessageToPC(GetFirstPC(), "Level Up Failed For "
                                          + GetName(oHenchman)
                                          + " in class "
                                          + IntToString(nClassToLevelUp));
            return;
        }
    }
}

*/

//Not used due to henchman lags
/*
//  levels up the henchman assigned to oPC
void LevelUpXP1Henchman(object oPC)
{
    if ( !GetIsObjectValid(oPC) )
        return;

    object oAssociate = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC);
    if ( !GetIsObjectValid(oAssociate) )
        return;

    int nResult;
    int nTargetLev = GetTargetLevel();
//    int nLevel = GetHitDice(oPC);
    int nLevel = nTargetLev+1;   //modified
    string sTag = GetStringLowerCase(GetTag(oAssociate));
    if ( sTag == "MARCUS" )
    {
        LevelHenchmanUpTo(oAssociate, nLevel, CLASS_TYPE_FIGHTER, 2);
    } else if (sTag == "x0_hen_dor")
    {              //  SpawnScriptDebugger();
        LevelHenchmanUpTo(oAssociate, nLevel, CLASS_TYPE_CLERIC, 20);
    }
    else if (sTag == "x0_hen_dee")
    {
        LevelHenchmanUpTo(oAssociate, nLevel, CLASS_TYPE_ROGUE, 0);
    }
    else
    {
        LevelHenchmanUpTo(oAssociate, nLevel);
    }
}
*/
