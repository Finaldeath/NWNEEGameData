//::///////////////////////////////////////////////
//:: FileName oe_ac_trg_roo
//:: PC is triggered to run up to Roo and start convo
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/2/2006 3:25:02 PM
//:://////////////////////////////////////////////
void main()
{
object oPC = GetEnteringObject();
object oR = GetObjectByTag("ac_rootherat");
if (!(GetIsPC(oPC))) return;
if (GetLocalInt(OBJECT_SELF, "fired")== 1) return;
SetLocalInt(OBJECT_SELF,"fired",1);

SetCutsceneMode(oPC, TRUE);
AssignCommand(oPC, ActionMoveToObject(oR, TRUE, 3.0));
AssignCommand(oPC, ActionStartConversation(oR));
DelayCommand(2.0, SetCutsceneMode(oPC, FALSE));
}
