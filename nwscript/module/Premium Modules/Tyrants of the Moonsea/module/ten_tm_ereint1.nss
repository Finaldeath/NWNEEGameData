void main()
{

object oPC = GetEnteringObject();

object oEremuth = GetObjectByTag("Eremuth");

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

AssignCommand(oPC, ClearAllActions());

SetLocalInt(oPC, "eremuth_inter", 1);

AssignCommand(oEremuth, ActionStartConversation(oPC));
}
