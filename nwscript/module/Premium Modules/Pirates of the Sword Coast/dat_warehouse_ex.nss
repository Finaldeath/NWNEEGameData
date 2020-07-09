////////////////////////////////////////////////////////////
// dat_warehouse_ex
// Based on NW_G0_Transition.nss
// Copyright (c) 2001 Bioware Corp.
////////////////////////////////////////////////////////////
/*
    Put in an extra check so that a player involved in
    a fight with Redtip can not leave.
*/
////////////////////////////////////////////////////////////
#include "inc_global"

const string CANNOT_LEAVE = "You must fight this battle to its bitter end.";

void main()
{
    object oClicker = GetClickingObject();

    //Standard Possessed Familiar Blockade. Not sure if it makes some of the
    //checks below redundant...
    if (GetIsPossessedFamiliar(oClicker) == TRUE)
    {
        string sMessage = "You dare not stray far from your master.";
        FloatingTextStringOnCreature(sMessage, oClicker);
    }
    // * Only PC's or associates of pc's can do this
    else if (GetIsPC(oClicker) || GetIsPC(GetMaster(oClicker)) == TRUE)
    {
        object oRedtip = GetObjectByTag(a2c_tag_Redtip);
        // if the brawl isn't active, or if it is active but the player
        // isn't the one involved in the fight, then allow the transition
        if( (!GetLocalInt(oRedtip, l_n_REDTIP_BRAWL_ON)) ||
            (GetLocalObject(oRedtip, l_o_REDTIP_BRAWL_PLAYER_OBJECT) != oClicker) )
        {
            object oTarget = GetTransitionTarget(OBJECT_SELF);

            //SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);

            AssignCommand(oClicker,JumpToObject(oTarget));
        }
        else
        {
            // if we're not allowing them to leave, give them a floaty
            // explaining why
            FloatingTextStringOnCreature(CANNOT_LEAVE, oClicker);
        }
    }
 /* else
  This turned out to be unnecessary since GetIsPC returns true
  if a player controlled, which includes familiars.
  // * This is an NPC attempting to cross the transition
  // * Clear all actions on it (to prevent system
  // * resource eating by a creature trying to cross
  // * an area transition that it can't
  {
    AssignCommand(oClicker, ClearAllActions());
  }
  */
}
