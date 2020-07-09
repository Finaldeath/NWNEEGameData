void acCreate(object oPC)
{
if (IsInConversation(oPC)) return;
object oD = CreateObject(OBJECT_TYPE_CREATURE, "ac_davey", GetLocation(oPC));
AssignCommand(oPC, ClearAllActions());
DelayCommand(0.5, AssignCommand(oD, ActionStartConversation(oPC)));
SetLocalInt(OBJECT_SELF,"fired",1);
}
void main()
{
object oPC = GetEnteringObject();
if (!(GetIsPC(oPC))) return;
if (GetLocalInt(OBJECT_SELF,"fired")==1) return;
DelayCommand(3.0,acCreate(oPC));
}
