int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if (GetLocalInt(oPC, "nWH_SpokeGuruk") == 1) return TRUE; // spoke to ogre king
    else return FALSE;
}
