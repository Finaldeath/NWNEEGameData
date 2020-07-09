// January 2006
// B W-Husey
// Imelda's current offer price for the document/blackmail
#include "cu_functions"

void main()
{
    object oPC = GetPCSpeaker();
    AllParty("nIOffer",oPC,100);
    ExecuteScript("dla_atimeldatoke",oPC);
}
