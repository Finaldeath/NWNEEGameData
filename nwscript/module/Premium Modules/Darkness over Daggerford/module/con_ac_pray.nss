//::///////////////////////////////////////////////
//:: FileName con_ac_pray
//:: Raegen kneels down to pray to Helm.
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 02/04/2006 4:53:00 PM
//:://////////////////////////////////////////////
#include "x2_inc_cutscene"
void main()
{
object oPC = GetPCSpeaker();
ActionPauseConversation();
DelayCommand(1.0,ActionResumeConversation());
ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0,3.0);
CutFadeOutAndIn(0.3, oPC, 2.0);
}
