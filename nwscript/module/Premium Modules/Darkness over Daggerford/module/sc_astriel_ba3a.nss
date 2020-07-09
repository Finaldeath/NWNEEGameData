// has the player found captain herab's desk yet?

int StartingConditional()
{
    if((GetLocalInt(GetModule(),"barge_activity") == 3) ||
        GetLocalInt(GetModule(),"barge_activity") == 4)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
