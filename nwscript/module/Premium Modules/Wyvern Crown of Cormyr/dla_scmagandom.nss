//::///////////////////////////////////////////////
//:: FileName dla_scallrandom
//:: Created By: B W-Husey
//:: Created On: 07/10/2005 14:00:37
//:: Default random response script usable on any character. Add to the'Text appears when' of any
//:: dialogue branch (except the last option).
//:://////////////////////////////////////////////
// Magurk's version - also checks if he has told his story today

int StartingConditional()
{
    object oPC =GetPCSpeaker();
    // Add the randomness
    if(Random(3) < 1)
        return FALSE;
    //Magurk already told his story today
    if (GetLocalInt(oPC,"nTallDay") == GetCalendarDay())
        return FALSE;
    return TRUE;
}
