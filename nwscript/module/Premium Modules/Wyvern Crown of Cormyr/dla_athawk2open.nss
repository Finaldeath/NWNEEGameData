// April 2004
// B W-Husey
// Polter's Fort is opened up.
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

string sName = "nPolterOpen";

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    AllParty(sName,oPC,1);                                    //Just sets variable
    }

}

