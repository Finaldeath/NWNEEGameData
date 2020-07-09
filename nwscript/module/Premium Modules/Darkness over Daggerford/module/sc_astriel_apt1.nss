//returns true if the player has persuaded astriel to pay more
//for the Daggerford missions
//Author: Damian Brown (Luspr)
//Date: 27-07-2005

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetLocalInt(oPC, "astriel_persuade_true")==1)
    return TRUE;
    return FALSE;
}
