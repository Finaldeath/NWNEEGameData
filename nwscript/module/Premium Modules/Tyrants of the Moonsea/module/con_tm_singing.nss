// returns true if the ambient AI for bards is not singing

int StartingConditional()
{
    int nSinging = GetLocalInt(OBJECT_SELF, "HF_SINGING");
    if (nSinging > 0)
        return FALSE;
    return TRUE;
}
