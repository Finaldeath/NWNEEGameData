//November 2005
//B W-Husey
//Alice job variable is less than 2 (i.e <2 jobs have already been offered)
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "nAliceJob") < 2))
        return FALSE;

    return TRUE;
}
