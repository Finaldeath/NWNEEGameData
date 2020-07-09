int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oDoors = GetNearestObjectByTag("dt_dig_exit", oPC);
    return(GetLocked(oDoors));
}
