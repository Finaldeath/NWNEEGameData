//::///////////////////////////////////////////////
//:: dla_d2_istied
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Check if the horse is tied to a hitching post
   Use switch DLA_ONLY_OWNER_CAN_UNTIE_HORSE to
   determine if the option should appear
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: Dec 10, 2005
//:://////////////////////////////////////////////

#include "dla_i0_horseai"
#include "dla_i0_switches"

int StartingConditional()
{
    if (!DLA_GetIsTied()) return FALSE;

    object oHorseOwner = GetLocalObject(OBJECT_SELF, "oDLA_HORSE_OWNER");

    if ((!GetIsObjectValid(oHorseOwner)) ||
    (DLA_ONLY_OWNER_CAN_UNTIE_HORSE && oHorseOwner == GetPCSpeaker()) ||
    (DLA_PLAYER_CAN_UNTIE_NPC_HORSE && GetMaster(oHorseOwner) == GetPCSpeaker()))
          return TRUE;

    return FALSE;
}
