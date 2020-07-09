//::///////////////////////////////////////////////
//:: FileName dla_scallrandom
//:: Created By: B W-Husey
//:: Created On: 07/10/2005 14:00:37
//:: Default random response script usable on any character. Add to the'Text appears when' of any
//:: dialogue branch (except the last option). Used on barrows PDKs so they can only be sent home once for xp
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Add the randomness
    if(Random(3) < 1 || GetLocalInt(OBJECT_SELF,"nSent")>0)
        return FALSE;

    return TRUE;
}
