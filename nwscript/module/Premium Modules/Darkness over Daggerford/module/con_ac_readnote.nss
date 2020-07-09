//::///////////////////////////////////////////////
//:: FileName con_ac_readnote
//:: Millie reads note during convo
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: Feb. 5, 2006
//:://////////////////////////////////////////////
#include "x2_inc_cutscene"
void main()
{
object oPC = GetPCSpeaker();
ActionPlayAnimation(ANIMATION_FIREFORGET_READ);
CutFadeOutAndIn(0.5, oPC, 2.0);
ActionPauseConversation();
DelayCommand(2.0, ActionResumeConversation());
SetLocalInt(GetObjectByTag("ac_eustachia"), "has_met_pc", 1);
DestroyObject(GetObjectByTag("ac_porto"));
}
