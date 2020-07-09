//::///////////////////////////////////////////////
//:: FileName oe_ac_trg_jonas
//:: Jonas starts conversation if he's inside
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 3:25:02 PM
//:://////////////////////////////////////////////
void main()
{
object oPC = GetEnteringObject();
object oJ = GetObjectByTag("ac_jonas1");
if (!(GetIsPC(oPC))) return;
if (GetLocalInt(OBJECT_SELF, "fired2")== 1) return;
if (!(GetTag(GetArea(oJ))=="C1AR0704AJonasHouseMainFloor")) return;
SetLocalInt(OBJECT_SELF,"fired2",1);

DelayCommand(2.0, AssignCommand(oJ, ActionMoveToObject(oPC, TRUE)));
DelayCommand(2.1, AssignCommand(oJ, ActionStartConversation(oPC)));
//SetCutsceneMode(oPC, TRUE);
//DelayCommand(3.0, SetCutsceneMode(oPC, FALSE));
}
