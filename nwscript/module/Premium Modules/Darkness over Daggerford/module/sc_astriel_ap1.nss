//check to see if Astriel has paid the PC advance monies on Daggerford missions
//Author: Damian Brown (Luspr)
//Date: 27-07-2005
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetLocalInt(oPC, "astriel_pays") !=1)
    return TRUE;//pc has not been paid
    return FALSE;//pc has been paid
}
