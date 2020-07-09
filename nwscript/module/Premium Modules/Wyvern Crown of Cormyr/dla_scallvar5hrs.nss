//::///////////////////////////////////////////////
//:: dla_scallvar5hrs
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    The conversation node can only be shown one time,
    and only if the NPC speaker is not mounted,
    and no horse from party is assigned to the NPC
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: May 19, 2006
//:://////////////////////////////////////////////

// Modified version for Wangle of the standard variable 5 conversation, used to detect horses

#include "dla_i0_horse"

int StartingConditional()
{
    object oNPC = OBJECT_SELF;
    object oHorseAssigned = GetLocalObject(oNPC,"oAssigned");
    object oPC = GetPCSpeaker();
    object oHorseAssignedMaster = GetMaster(oHorseAssigned);

    //if a horse is assigned to the NPC, and it's on party
    if (GetIsObjectValid(oHorseAssigned) && (oHorseAssignedMaster == oPC ||
    oHorseAssignedMaster == oNPC))
        return FALSE;

    //if it's mounted, don't show up
    if (DLA_GetIsMounted(oNPC))
        return FALSE;

    string sName = "Var5"+GetTag(oNPC);       //Set variable to object's tag + extra bit
    return !GetLocalInt(GetPCSpeaker(), sName);  //Check to see if PC has tried this before
    //do not allow this conversation branch if done before
}


