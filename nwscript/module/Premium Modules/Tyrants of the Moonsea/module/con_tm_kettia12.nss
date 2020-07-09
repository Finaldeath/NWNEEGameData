//Kettia is in Zhentil Keep war-zone

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetTag(GetArea(oPC)) == "zhentkeepwar" &&
        GetLocalInt(OBJECT_SELF, "nZhentilKeepWar") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
