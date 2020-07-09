int StartingConditional()
{
    if (GetLocalInt(GetModule(), "nTriggerPlot") == 2)
    {
        SetLocalInt(GetModule(), "nTriggerPlot", 3);
        SetCutsceneMode(GetPCSpeaker(), FALSE);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
