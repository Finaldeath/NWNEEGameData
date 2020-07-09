int StartingConditional()
{
    //Astriel is attracted to the PC
    object oPC = GetPCSpeaker();
    if(GetLocalInt(oPC, "astriel_charmed") ==1)
    return TRUE;
    return FALSE;
}
