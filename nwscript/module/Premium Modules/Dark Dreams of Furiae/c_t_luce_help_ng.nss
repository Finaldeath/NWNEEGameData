int StartingConditional()
{
    int iQuillInJail = GetLocalInt(GetModule(), "ddf_quill_in_jail");
    int iTellLucennaTruth = GetLocalInt(GetModule(), "ddf_luce_truth");
    int iAlignmentGoodEvil = GetAlignmentGoodEvil(GetPCSpeaker());

    // If Quillian is turned in or you told the truth and you are not good aligned
    if ((iQuillInJail == TRUE || iTellLucennaTruth == TRUE) && iAlignmentGoodEvil != ALIGNMENT_GOOD)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
