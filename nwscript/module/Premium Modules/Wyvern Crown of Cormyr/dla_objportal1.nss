void main()
{
    object oPC = GetLastUsedBy();
    object oTarget = GetWaypointByTag("TP_WLOut");
    AssignCommand(oPC,JumpToObject(oTarget));
}
