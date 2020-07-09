//Does the player have an evil alignment?
int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
