// Returns true if the player is good AND quill's in jail

int StartingConditional()
{
    if (!GetLocalInt(GetModule(), "ddf_quill_in_jail") && !GetLocalInt(GetModule(), "ddf_luce_truth"))
        return FALSE;
    if (GetAlignmentGoodEvil(GetPCSpeaker()) < 70)
        return FALSE;

    return TRUE;
}
