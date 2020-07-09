int StartingConditional()
{
    if (GetLocalInt(GetModule(), "nTriggerPlot") == 0)
    {
        SetLocalInt(GetModule(), "nTriggerPlot", 1);
        SetCutsceneMode(GetPCSpeaker(), FALSE);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
