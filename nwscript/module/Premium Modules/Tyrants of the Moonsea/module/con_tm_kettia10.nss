//Kettia speaks at end of Naval Battle

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetTag(GetArea(oPC)) == "MoonseaBattle" &&
        GetLocalInt(OBJECT_SELF, "nPiratesLeft") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
