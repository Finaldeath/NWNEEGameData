int StartingConditional()
{
    int iQuillInJail = GetLocalInt(GetModule(), "ddf_quill_in_jail");
    int iTellLucennaTruth = GetLocalInt(GetModule(), "ddf_luce_truth");

    // If Quillian isn't turned in or you didn't tell the truth
    if (iQuillInJail == FALSE || iTellLucennaTruth == FALSE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
