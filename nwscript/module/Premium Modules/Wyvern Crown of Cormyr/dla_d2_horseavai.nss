//::///////////////////////////////////////////////
//:: dla_d2_horseavai
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Conversation file for henchman.
   Returns TRUE if the henchman or it's master has
   a horse available to mount.
*/
//:://////////////////////////////////////////////
//:: Create By: Gale
//:: Created On: Nov 24, 2005
//:://////////////////////////////////////////////


#include "dla_i0_horse"

int StartingConditional()
{

  return
  (GetIsObjectValid(DLA_GetHorseHenchman(OBJECT_SELF,1)) ||
  GetIsObjectValid(DLA_GetHorseHenchman(GetPCSpeaker(),1))) &&
       !DLA_GetIsMounted(OBJECT_SELF);

}
