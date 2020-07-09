//::///////////////////////////////////////////////
//:: FileName ohb_ac_bard
//:: Bard plays music on heartbeat.
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/20/2005 2:13:17 PM
//:://////////////////////////////////////////////
#include "NW_I0_PLOT"

void main()
{
if (IsInConversation(OBJECT_SELF)) return;
effect eS = EffectVisualEffect(468);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eS, OBJECT_SELF, 5.5);
ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 0.02, 5.5);
}

