int StartingConditional()
{
    object oPC = GetMaster();
    if(GetIsObjectValid(oPC) == TRUE) return TRUE;
    return FALSE;
}
