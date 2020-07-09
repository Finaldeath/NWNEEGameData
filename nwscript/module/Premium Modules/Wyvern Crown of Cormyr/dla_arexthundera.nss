// October 2005
// B W-Husey
// This OnExit script is used on Thunderstone Town Arrest Area.
// It checks the weather and sets up the environment dependant on that
// Returns horses held in the Thunderstone Town area.
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
    DLA_ReturnOwnedHorsesOnAreaToPCParty(oPC,GetArea(GetObjectByTag("CP_Cut1End")));
    }
}
