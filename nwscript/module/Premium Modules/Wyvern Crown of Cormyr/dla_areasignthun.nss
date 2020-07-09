// October 2005
// B W-Husey
// Unequip weapons from hand
// Modified 6/19/2006 - to deal with Lacinda's horse appearing.

#include "cu_functions"
#include "dla_i0_horse"
#include "x0_inc_henai"


void fnJump(object oHorse,object oDest)
{ // PURPOSE: Jump
  if (GetArea(oDest)!=GetArea(oHorse)||GetDistanceBetween(oHorse,oDest)>5.0)
  { // jump
      SetAILevel(oHorse,AI_LEVEL_NORMAL);
      AssignCommand(oHorse,ClearAllActions(TRUE));
      AssignCommand(oHorse,JumpToObject(oDest));
      DelayCommand(1.0,fnJump(oHorse,oDest)); // make sure it is moved
  } // jump
  else
  { // arrived
      DLA_HorseDebug("  "+GetName(oHorse)+" arrived hitched in area '"+GetName(GetArea(oDest))+"'");
      DLA_SetIsTied(oHorse,TRUE);
      SetAssociateState(NW_ASC_MODE_STAND_GROUND,TRUE,oHorse);
      SetAILevel(oHorse,AI_LEVEL_DEFAULT);
  } // arrived
} // fnJump()


void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);

    if (GetIsDefPC(oPC))
    {
    //disarm entering party and store what weapons they used
    DisarmParty(oPC);
    }
    else
    { // is npc
       if (DLA_GetIsDLAHorse(oPC))
       { // this is a horse
           DLA_HorseDebug("  Horse is being hitched outside Sign of Thunder");
           oArea=GetWaypointByTag("WP_lachorsestand");
           SetAILevel(oPC,AI_LEVEL_NORMAL);
           fnJump(oPC,oArea);
       } // this is a horse
    } // is npc
}
