//returns true if the player has failed to persuade Astriel to pay more
//for the Daggerford missions
//Author: Damian Brown (Luspr)
//Date: 27-07-2005

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetLocalInt(oPC, "astriel_persuade_true")==2)
    return TRUE;
    return FALSE;
}
