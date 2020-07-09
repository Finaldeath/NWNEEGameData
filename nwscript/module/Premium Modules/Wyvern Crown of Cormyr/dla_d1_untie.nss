//::///////////////////////////////////////////////
//:: dla_d1_untie
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Untie the horse from the hitching post it is tied to
   Use switch DLA_ONLY_OWNER_CAN_UNTIE_HORSE to
   determine if the option should appear
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: Dec 10, 2005
//:://////////////////////////////////////////////
// Last modified By: Deva B. Winblood  May 11, 2006
//                      used DLA_UntieHorse() function


#include "dla_i0_horseai"
#include "dla_i0_switches"
#include "dla_i0_strings"
#include "dla_i0_debug"
#include "dla_i0_horse"

void main()
{
    object oHorseOwner;
    object oHorse = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    if (!DLA_GetIsTied()) return;

    oHorseOwner = GetLocalObject(oHorse, "oDLA_HORSE_OWNER");

    if ((!GetIsObjectValid(oHorseOwner)) ||
    (DLA_ONLY_OWNER_CAN_UNTIE_HORSE && oHorseOwner == oPC) ||
    (DLA_PLAYER_CAN_UNTIE_NPC_HORSE && GetMaster(oHorseOwner) == oPC))
    {
          DLA_UntieHorse(oHorse);
    }

}
