// B W-Husey
// August 2005
// PC uses the area transition via conversation to jump to the desired location. Locations
// available are controlled by variables set on the trigger and by the state of the plot variable nMainPlot
// (This has been modularised so the previous state is unimportant when this is changed).
// Cost and time are applied, and the PC is refreshed (i.e. rested) during travel since this version
// is for using inns. A wandering monster check fires, and if monsters are generated the PC is diverted to an
// encounter area.
#include "cu_functions"
#include "cu_wandering"
void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC,"nNotInn",0);//using inns
    //gather up all the parties horses and add them back to the party, in case left on a post
    DLA_ReturnOwnedHorsesOnAreaToPCParty(oPC);
    if (GetLocalInt(oPC,"nSpy")==9 && GetLocalInt(oPC,"nMainPlot")>3)//planned encounter from To Catch A Spy sidequest
    {
        location lLoc = GetLocation(GetWaypointByTag("WP_SpyEncounter"));
        AssignCommand(oPC,JumpToLocation(lLoc));
    }
    else if (GetLocalInt(oPC,"nKatComplete")==1 && GetInParty("Kathryn",oPC) == TRUE)//Kathryn has told her story - Fire Knives attack
    {
        SetLocalInt(oPC,"nKatComplete",2);
        location lLoc = GetLocation(GetWaypointByTag("WP_KatEncounter"));
        AssignCommand(oPC,JumpToLocation(lLoc));
    }
    else   //random encounter check
    {
        if (WandMonCheck(oPC,1,18,"Null",TRUE)==0)
        DoTravelInn(oPC);
    }
}