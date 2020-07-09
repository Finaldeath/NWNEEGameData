//Kettia speaks at start of Naval Blockade cutscene

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetTag(GetArea(oPC)) == "MoonseaBlockade")
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
