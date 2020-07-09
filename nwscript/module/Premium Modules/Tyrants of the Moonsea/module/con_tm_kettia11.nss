//Kettia speaks at end of Naval Battle having already spoken her primary dialog

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetTag(GetArea(oPC)) == "MoonseaBattle" &&
        GetLocalInt(OBJECT_SELF, "nPiratesLeft") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
