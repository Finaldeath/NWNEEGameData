// if player was NOT disguised when speaking with Redeye the first time
// .. and has become disguised, Redeye will compliment the player
// .. (only once of course).

#include "inc_polymorph"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if (!IsPolymorphed(oPC))
    {
        return(FALSE);
    }

    if (GetLocalInt(OBJECT_SELF, "nSeenPlayerPolymorphed") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nSeenPlayerPolymorphed", 1);
        return(TRUE);
    }

    return(FALSE);
}
