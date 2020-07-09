int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetLocalInt(oPC, "astriel_pays")==2)
    return TRUE;
    return FALSE;
}
