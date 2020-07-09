int StartingConditional()
{
    if (GetLocalInt(GetNearestObjectByTag("GuardTalkTrigger"), "nDone") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
