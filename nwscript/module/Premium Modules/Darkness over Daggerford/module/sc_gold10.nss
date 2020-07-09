//sc_gold10
//This is a starting conditional that checks that the PC speaker
//  has at least 5 gold pieces.
//Author: Anya Clancy
//Date: Oct 8, 2005

int StartingConditional()
{

    object oPC = GetPCSpeaker();
    if (!GetGold(oPC) >= 10) return FALSE;
    return TRUE;

}
