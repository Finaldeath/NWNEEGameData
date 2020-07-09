// Jump to Wyvernwatercastle portal  (or the sinking one)

void main()
{
       object oPC = GetLastUsedBy();
       if (GetLocalInt(oPC,"nMainPlot")<6)   AssignCommand(oPC,JumpToObject(GetObjectByTag("CWPortal1")));
       else   AssignCommand(oPC,JumpToObject(GetObjectByTag("CWSPortal1")));
}
