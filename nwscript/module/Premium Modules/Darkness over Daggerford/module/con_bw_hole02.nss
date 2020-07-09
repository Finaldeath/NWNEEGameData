void main()
{
    object oPC = GetPCSpeaker();
    object oWP = GetObjectByTag("wp_ar0807_entry");
    location lWP = GetLocation(oWP);

    SetLocalInt(oPC, "nAR0800_JumpedHole", 1);

    int nNth = 1;
    object oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nNth);
    while (GetIsObjectValid(oHench))
    {
        SetLocalInt(oHench, "nAR0800_JumpedHole", 1);

        nNth += 1;
        oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nNth);
    }

    object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
    if (GetIsObjectValid(oDominated))
    {
        SetLocalInt(oDominated, "nAR0800_JumpedHole", 1);
    }

    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, JumpToLocation(lWP));
}
