//Love of a lord quest started but no progress
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nWStag") == 1))
        return FALSE;

    return TRUE;
}
