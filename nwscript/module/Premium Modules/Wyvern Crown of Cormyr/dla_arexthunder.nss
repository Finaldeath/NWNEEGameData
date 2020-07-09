// October 2005
// B W-Husey
// Area exit script to rearm party.

#include "cu_functions"

void main()
{
    object oPC = GetExitingObject();
    object oArea = GetArea(oPC);
    if (GetIsDefPC(oPC))
    {
    StoreMyWeather(oPC,oArea);
    //debug line ************
    //    SendMessageToPC(oPC,"Storing Weather");
    RearmParty(oPC);
    }
}
