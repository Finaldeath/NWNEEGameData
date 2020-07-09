// has the player been given the barge activity quest yet?

int StartingConditional()
{
    if(GetLocalInt(GetModule(), "iBargeQuestGiven") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
