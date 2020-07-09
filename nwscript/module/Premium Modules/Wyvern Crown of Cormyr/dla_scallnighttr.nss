// B W-Husey
// Don't offer jousting at night in Thunderstone, when the tourney would normally be open.

int StartingConditional()
{
    if (GetStringLeft(GetTag(GetArea(GetPCSpeaker())),6) == "Thunde" || GetStringLeft(GetTag(GetArea(GetPCSpeaker())),6) == "Hawkli")
    {
        if (GetIsNight() && GetLocalInt(GetPCSpeaker(),"nMainPlot")==1)    return TRUE;
        if (GetIsNight() && GetLocalInt(GetPCSpeaker(),"nMainPlot")==7)    return TRUE;
    }
    return FALSE;
}
