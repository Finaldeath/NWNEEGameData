// returns true if the end game is running

int StartingConditional()
{
    object oMod = GetModule();
    return(GetLocalInt(oMod, "pm_endgame_start") == 1);
}
