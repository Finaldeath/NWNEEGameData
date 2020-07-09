//No more jobs until later in the mod/not today
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nAliceJob") > 0))
        return FALSE;
    if(!(GetLocalInt(GetPCSpeaker(), "nMainPlot") < 3))
        return FALSE;
    if(GetLocalInt(GetPCSpeaker(),"nAJobDay")==GetCalendarDay())
        return TRUE;
    return TRUE;
}
