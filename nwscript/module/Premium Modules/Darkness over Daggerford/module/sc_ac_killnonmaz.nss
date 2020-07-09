//Check if player killed werewolves before maze
int StartingConditional()
{
    if((GetLocalInt(GetPCSpeaker(), "ac_kill_nonmaze") == 1) ||
       ((GetLocalInt(GetModule(), "iJonasDead") == 1) &&
       (GetLocalInt(GetModule(), "iJuniorDead") == 1) &&
       (GetLocalInt(GetModule(), "ac_werewolf") < 3)))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
