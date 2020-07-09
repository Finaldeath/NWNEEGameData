int StartingConditional()
{
    if (GetLocalInt(GetModule(), "nTriggerPlot") == 1)
    {
        SetLocalInt(GetModule(), "nTriggerPlot", 2);
        SetCutsceneMode(GetPCSpeaker(), FALSE);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
