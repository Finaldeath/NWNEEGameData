int StartingConditional()
{
    if (GetLocalInt(GetModule(), "nTriggerPlot") == 4)
    {
        SetLocalInt(GetModule(), "nTriggerPlot", 5);
        SetCutsceneMode(GetPCSpeaker(), FALSE);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
