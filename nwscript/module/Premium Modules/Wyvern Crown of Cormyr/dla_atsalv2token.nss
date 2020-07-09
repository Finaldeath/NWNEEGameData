// January 2006
// B W-Husey
// Used to set custom conversation tokens for number of bandits killed and who the PC's
// companions are. More than 2 kills, make a horse for the PC.
// Modified by Deva B. Winblood  7/30/2006  Mantis #1768

#include "cu_functions"
#include "dla_i0_horse"

void main()
{
    object oPC = GetPCSpeaker();
    object oHench1 = ReturnHenchman(oPC,1);
    object oHench2 = ReturnHenchman(oPC,2);
    object oHorse;
    //set custom token based on names of henchmen.
    if (GetIsObjectValid(oHench2))  SetCustomToken(1024,", "+GetName(oHench1)+" and "+GetName(oHench2));
    else if (GetIsObjectValid(oHench1)) SetCustomToken(1024," and "+GetName(oHench1));
    //Set custom token that counts number of bandit kills.
    int nKills = GetLocalInt(oPC,"nBandits") + GetLocalInt(oHench1,"nBandits") + GetLocalInt(oHench2,"nBandits");
    if (nKills == 0) SetCustomToken(1023,"didn't kill any of the bandits, but nevermind");
    else SetCustomToken(1023,"killed "+IntToString(nKills)+" of the bandits");
    if (nKills>2 && GetLocalInt(oPC,"nBHorse")<1)
    {
        location lLoc = GetLocation(GetWaypointByTag("WP_BHorseSpawn"));
        oHorse=CreateObject(OBJECT_TYPE_CREATURE,"bandithorse",lLoc,FALSE);
        SetAILevel(oHorse,AI_LEVEL_DEFAULT);
        SetCommandable(TRUE,oHorse);
        DLA_SetHenchman(oHorse,oPC,TRUE,TRUE);
        AllParty("nBHorse",oPC,1);
    }
}
