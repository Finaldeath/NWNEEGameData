int StartingConditional()
{
    if (GetLocalInt(GetModule(), "nTriggerPlot") == 3)
    {
        SetLocalInt(GetModule(), "nTriggerPlot", 4);
        SetCutsceneMode(GetPCSpeaker(), FALSE);

        return TRUE;
    } else
    {
        return FALSE;
    }
}
