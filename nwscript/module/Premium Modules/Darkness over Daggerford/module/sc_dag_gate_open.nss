int StartingConditional()
{
    //returns true if the Daggerford gates remain locked
    if(GetLocalInt(GetModule(), "pm_Daggerford_open") !=1)
    return TRUE;
    return FALSE;
}
