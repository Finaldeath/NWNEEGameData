void main()
{

object oPC = GetEnteringObject();

object oAstar = GetObjectByTag("Astar");

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

AssignCommand(oAstar, ClearAllActions());

AssignCommand(oPC, ClearAllActions());

SetLocalInt(oPC, "astar_inter", 1);

AssignCommand(oAstar, ActionStartConversation(oPC));
}
