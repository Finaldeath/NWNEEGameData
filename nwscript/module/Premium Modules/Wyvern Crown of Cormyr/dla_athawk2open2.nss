// February 2006
// B W-Husey
// Lake Wyvernwater is opened up.
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

string sName = "nLWOpen";

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    AllParty(sName,oPC,1);                                    //Just sets variable
    }

}

