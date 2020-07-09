//Kettia is in Zhentil Keep war-zone and has already spoken to PC

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetTag(GetArea(oPC)) == "zhentkeepwar" &&
        GetLocalInt(OBJECT_SELF, "nZhentilKeepWar") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
