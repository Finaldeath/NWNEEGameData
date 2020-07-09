//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: con_tm_zeltoon2
// DATE: December 3, 2005
// AUTH: Luke Scull
// NOTE: Appears if player hasn't chosen "Then you're
//       a merchant" dialogue.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "zeltoonmerchant") != 1))
        return FALSE;

    return TRUE;
}
