//::///////////////////////////////////////////////
//:: FileName dla_scallrandom
//:: Created By: B W-Husey
//:: Created On: 07/10/2005 14:00:37
//:: Default random response script usable on any character. Add to the'Text appears when' of any
//:: dialogue branch (except the last option).
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Add the randomness
    if(Random(10) < 1)
        return TRUE;

    return FALSE;
}
