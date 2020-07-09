// B W-Husey
// Don't offer jousting in Thunderstone, when the tourney is closed on the tourney entry gates.

int StartingConditional()
{
//if (GetStringLeft(GetTag(GetArea(GetPCSpeaker())),6) == "Thunde" || GetStringLeft(GetTag(GetArea(GetPCSpeaker())),6) == "Hawkli")
    if(GetTag(OBJECT_SELF)=="HCEast" || GetTag(OBJECT_SELF)=="TEast1" )
    {
        if (GetLocalInt(GetPCSpeaker(),"nMainPlot")==1)    return FALSE;
        if (GetLocalInt(GetPCSpeaker(),"nMainPlot")==7)    return FALSE;
        return TRUE;
    }
   return FALSE;
}
