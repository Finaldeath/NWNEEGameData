//::///////////////////////////////////////////////
//:: FileName con_ac_convo
//:: Initiate convo with PC
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 3:22:44 PM
//:://////////////////////////////////////////////
void ahcFace(object o1, object o2)
{
AssignCommand(o1, ActionDoCommand(SetFacingPoint(GetPosition(o2))));
AssignCommand(o1, ActionStartConversation (o2));
}

void main()
{
object oPC = GetEnteringObject();
if (!(GetIsPC(oPC))) return;
if (GetLocalInt(OBJECT_SELF,"fired")==1) return;
SetLocalInt(OBJECT_SELF,"fired",1);
SetCutsceneMode(oPC,TRUE);
ahcFace(oPC, OBJECT_SELF);
AssignCommand(GetObjectByTag("ac_blackdragon"),ActionStartConversation(oPC));
}
