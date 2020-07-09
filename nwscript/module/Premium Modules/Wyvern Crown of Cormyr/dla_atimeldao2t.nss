// January 2006
// B W-Husey
// NPC rewards template to be used after an action
// Imelda persuaded for balckmail. Set nIOffer to amount.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

    AllParty("nIOffer",oPC,2000);
    ExecuteScript("dla_atimeldatoke",oPC);
}


