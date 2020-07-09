//::///////////////////////////////////////////////
//:: dla_doorstable
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Script of placeable door, event OnUsed
    Properly animates the closed door being used
    and transitions when the open door is used
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: May 27, 2006
//:://////////////////////////////////////////////

#include "cu_functions"

void main()
{
      int nIsOpen = GetIsOpen(OBJECT_SELF);
      object oPC = GetLastUsedBy();

      if (nIsOpen) //It's open, make the transition
      {
          //Transitions to the object with the tag equal to the string stored
          //on the variable "sTransTarget" on the placeable door
          object oTarget = GetObjectByTag(GetLocalString(OBJECT_SELF, "sTransTarget"));
          AssignCommand(oPC,JumpToObject(oTarget));
          DelayCommand (0.1, DLA_SetAreaTransCameraFacing(oPC,oTarget));
      }
      else //It's closed, then open it
      {
         ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN);
         DelayCommand(30.0, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE));
      }
}

