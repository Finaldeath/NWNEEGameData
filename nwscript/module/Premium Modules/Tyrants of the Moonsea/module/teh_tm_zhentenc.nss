void main()
{
object oPC = GetFirstPC();

object oTarget = GetObjectByTag("WP_cut_elventree_pc_init");

int nCount=GetLocalInt(oPC, "zhentskilled");

nCount = nCount+1;

SetLocalInt(oPC, "zhentskilled", nCount);

if (!(nCount == 5))

return;

SetLocalInt(oPC, "elventreefinale", 1);



AssignCommand(oPC, ClearAllActions());

AssignCommand(oPC, JumpToObject(oTarget));

}



