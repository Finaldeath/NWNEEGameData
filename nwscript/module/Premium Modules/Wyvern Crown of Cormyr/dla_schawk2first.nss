// March 2006
// B W-Husey
// Hawklin's version od the generic first time talker script: uses tag of speaker to make unique variable.
// Checks plot variable as well (basically so we can skip this when testing later sections)
//  The main plot variable nMainPlot == 1
//:://////////////////////////////////////////////

int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nFirst"+GetTag(OBJECT_SELF)) == 0 && GetLocalInt(GetPCSpeaker(), "nMainPlot") == 1)
        return TRUE;

    return FALSE;
}


