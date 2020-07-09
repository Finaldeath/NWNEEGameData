//sc_ac_ngold500
//This is a starting conditional that checks that the PC speaker
//  doesn't have at least 500 gold pieces.
//Author: Anya Clancy
//Date: Oct 16, 2005

int StartingConditional()
{

    object oPC = GetPCSpeaker();
    if (!(GetGold(oPC) < 500)) return FALSE;
    return TRUE;

}
