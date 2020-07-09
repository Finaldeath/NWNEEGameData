////////////////////////////////////////////////////////////////////////////////
// wc_cnv_exit - Was the conversation exited when there is still dialog that
// needs to be handled?  If so kick the PC back into conversation with this
// henchman.
// Original Scripter:  Deva B. Winblood            DLA TEAM
// Last Modified By: Deva B. Winblood       5/02/2006
////////////////////////////////////////////////////////////////////////////////
#include "x0_i0_henchman"

/////////////////////////
// PROTOTYPES
/////////////////////////

void privateDLA_KeepTryingInterjection(object oPC,object oNPC);


/////////////////////////////////////////////////////////////[ MAIN ]///////////
void main()
{
    object oPC=GetPCSpeaker();
    int bHasInterjection=GetHasInterjection(oPC);
    if (bHasInterjection)
    { // an interjection exists that has not been dealt with
      privateDLA_KeepTryingInterjection(oPC,OBJECT_SELF);
    } // an interjection exists that has not been dealt with
}
/////////////////////////////////////////////////////////////[ MAIN ]///////////


//////////////////////////
// FUNCTIONS
//////////////////////////

void privateDLA_KeepTryingInterjection(object oPC,object oNPC)
{ // PURPOSE: To keep making PC try to handle interjection until they have
  // chosen a choice that indicates they have acknowledged it.
  // Original Scripter: Deva B. Winblood
  // Last Modified By: Deva B. Winblood   5/02/2006
  if (!GetIsInCombat(oPC)&&!IsInConversation(oPC))
  { // try interjection
    if (oNPC!=OBJECT_INVALID&&!GetIsDead(oNPC)&&GetDistanceBetween(oPC,oNPC)<30.0)
    { // NPC is still valid
      // Trigger the dialog again
      AssignCommand(oPC,ClearAllActions(TRUE));
      AssignCommand(oPC,ActionStartConversation(oNPC,GetTag(oNPC),FALSE,FALSE));
    } // NPC is still valid
  } // try interjection
  else
  { // wait for combat end
    if (oNPC!=OBJECT_INVALID&&!GetIsDead(oNPC)&&(GetObjectSeen(oPC,oNPC)||GetObjectHeard(oPC,oNPC)))
    { // NPC is still valid
      DelayCommand(2.0,privateDLA_KeepTryingInterjection(oPC,oNPC));
    } // NPC is still valid
  } // wait for combat end
} // privateDLA_KeepTryingInterjection()
