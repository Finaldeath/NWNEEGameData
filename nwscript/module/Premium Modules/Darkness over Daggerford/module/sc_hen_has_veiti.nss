// does the player have veiti as a living henchman

#include "hf_in_henchman"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oVeiti = GetNearestObjectByTag("db_veiti", oPC);
    if (GetIsObjectValid(oVeiti))
    {
        return(!GetIsDead(oVeiti));
    }
    return(FALSE);
}
