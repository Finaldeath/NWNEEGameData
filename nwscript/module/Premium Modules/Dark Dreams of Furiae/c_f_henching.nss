int StartingConditional()
{
    object oPC = GetMaster();
    if(GetIsObjectValid(oPC) == TRUE) return FALSE;
    return TRUE;
}
