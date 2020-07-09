////////////////////////////////////////////////////////////////////////////////
// dla_atcalad1fini.nss
//
// DLA Wyvern Crown of Cormyr
////////////////////////////////////////////////////////////////////////////////
/*
    Jump PC to the Final Battle
 */
////////////////////////////////////////////////////////////////////////////////
// Created by: B G P Hughes  (B W-Husey)
// Created on:
////////////////////////////////////////////////////////////////////////////////
/*
 Change history
 Date
 year/mm/dd |Author     | Change
 -----------+-----------+-------------------------------------------------------
 2006/06/18   Syrsnein  : Added additional calls to return owned horses.
 7th July     B W-Husey: Added delays as this is still not reliable.
 */

#include "cu_functions"
void main()
{
    object oPC = GetPCSpeaker();
     //Set the main plot variable to finish the module section.
    AllParty("nMainPlot",oPC,8);
    object oCalad = GetObjectByTag("Caladnei2");
    AssignCommand(oPC,JumpToLocation(GetLocation(GetWaypointByTag("WP_PCToBattle"))));
    DelayCommand(0.5,DLA_ReturnOwnedHorsesOnAreaToPCParty(oPC, GetArea(GetWaypointByTag("WP_MarkerHC"))));
    DelayCommand(0.7,DLA_ReturnOwnedHorsesOnAreaToPCParty(GetPCSpeaker(),GetArea(GetWaypointByTag("NameThund1"))));
    DelayCommand(0.8,DLA_ReturnOwnedHorsesOnAreaToPCParty(GetPCSpeaker(),GetArea(GetWaypointByTag("NameThund2"))));
    DelayCommand(0.9,DLA_ReturnOwnedHorsesOnAreaToPCParty(GetPCSpeaker(),GetArea(GetWaypointByTag("NameThund3"))));
    DelayCommand(1.0,DLA_ReturnOwnedHorsesOnAreaToPCParty(GetPCSpeaker(),GetArea(GetWaypointByTag("NameHawk"))));
    DelayCommand(8.0,AssignCommand(oCalad,ActionStartConversation(oPC,"caladnei2",FALSE,FALSE)));
}
