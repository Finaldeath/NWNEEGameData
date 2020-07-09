// TODO:DELETE
// Moved to cut_tm_zalazar

void main()
{

object oPC = GetEnteringObject();

object oSharalyn = GetObjectByTag("SharalynElventree");

if (!GetIsPC(oPC)) return;

if (GetLocalInt(oPC, "elventreeattacked")!= 1)
   return;

int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

AssignCommand(oSharalyn, ActionStartConversation(oPC));
}
