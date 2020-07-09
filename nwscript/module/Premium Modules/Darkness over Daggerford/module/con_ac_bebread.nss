//::///////////////////////////////////////////////
//:: FileName con_ac_bedread
//:: Beb-Shuur reads Master Vugu's journal.
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: Apr. 30, 2006
//:://////////////////////////////////////////////
#include "x2_inc_cutscene"
void main()
{
object oPC = GetPCSpeaker();
ActionPlayAnimation(ANIMATION_FIREFORGET_READ);
CutFadeOutAndIn(0.5, oPC, 2.0);
ActionPauseConversation();
DelayCommand(2.0, ActionResumeConversation());
}
