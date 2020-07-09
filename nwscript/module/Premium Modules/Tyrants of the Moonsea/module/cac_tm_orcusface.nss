//Orcus and his lieutenants turn to face the PC

void main()
{
    int i = 1;

    object oPC = GetPCSpeaker();
    object oOrcus = GetNearestObjectByTag("OrcusDemonPrinceoftheUndead", oPC);
    object oLieutenant;

    AssignCommand(oOrcus, SetFacing(DIRECTION_NORTH));

    oLieutenant = GetNearestObjectByTag("OrcusLieutenant", oPC, i);

    while(oLieutenant != OBJECT_INVALID)
    {
        AssignCommand(oLieutenant, SetFacing(DIRECTION_NORTH));
        i++;
        oLieutenant = GetNearestObjectByTag("OrcusLieutenant", oPC, i);
    }
}
