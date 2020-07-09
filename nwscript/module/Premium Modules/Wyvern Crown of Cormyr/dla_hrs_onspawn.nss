//:://////////////////////////////////////////////////
//:: dla_hrs_onspawn
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*

    OnSpawn event handler for horses

*/
//:://////////////////////////////////////////////
//:: Created By: DirgeSinger
//:: Created On: June 04, 2005
//:://////////////////////////////////////////////
//:: Updated By: Gale
//:: Updated On: Dec 10, 2005
//:: Modified By: Deva Winblood  May 15,2006

#include "x0_inc_henai"
#include "dla_i0_horse"

//Gale Dec 10, 2005
//Search for the variable DLA_TAG_HORSE_NPC_OWNER on oHorse.
//If it's find, then search the nearest NPC with the tag that match it.
// * Return value on error: OBJECT_INVALID
//OBS: This function is intended to be used only on OnSpawn event.
object DLA_GetHorseNPCOwner(object oHorse);

// Deva May 15, 2006
// This function will transfer assignment information and will also transfer
// despawn information from dismount.
void DLA_TransferVariables();

void main()
{

    //Gale 9 Dec 2005: Not a problem to run default OnSpawn script.
    //In fact, it make sure that nothing is broken with horses, and give better
    //support such as user defined events on OnSpawn

    //test
    effect eVis = EffectVisualEffect(654);
    ApplyEffectToObject(2, eVis, OBJECT_SELF);

    ExecuteScript("x2_def_spawn", OBJECT_SELF);


    //Use melee weapons by default
    SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);

    // Set starting location
    SetAssociateStartLocation();

    // Set respawn location
    SetRespawnLocation();

    // Allow horse to be raised/ressurected after death.
    //SetIsDestroyable(TRUE, TRUE, TRUE);

    // * Scan through all equipped items and makes ure they are identified
    int i = 0;
    object oItem;
    for(i = INVENTORY_SLOT_HEAD; i <= INVENTORY_SLOT_CARMOUR; i++)
    {
        oItem = GetItemInSlot(i, OBJECT_SELF);
        if(GetIsObjectValid(oItem) == TRUE)
            SetIdentified(oItem, TRUE);
    }

    object oNPCOwner = DLA_GetHorseNPCOwner(OBJECT_SELF);
    if (GetIsObjectValid(oNPCOwner)&&!GetLocalInt(oNPCOwner,"bGoingInside"))
        DLA_SetHenchman(OBJECT_SELF, oNPCOwner);
}

object DLA_GetHorseNPCOwner(object oHorse)
{
   string sNPCOwnerTag = GetLocalString(oHorse, DLA_TAG_HORSE_NPC_OWNER);
   if (sNPCOwnerTag == "") return OBJECT_INVALID;
   int i=1;
   object oNPC = GetNearestObjectByTag(sNPCOwnerTag);
   while ((GetObjectType(oNPC) != OBJECT_TYPE_CREATURE) && GetIsObjectValid(oNPC))
      oNPC = GetNearestObjectByTag(sNPCOwnerTag, OBJECT_SELF, ++i);
   return oNPC;
}

