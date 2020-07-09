//Kettia speaks at end of Naval Blockade cutscene

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetTag(GetArea(oPC)) == "MoonseaBlockade" &&
        GetLocalInt(OBJECT_SELF, "nPiratesBlockade") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
