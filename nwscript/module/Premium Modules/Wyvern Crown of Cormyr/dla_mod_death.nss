//::///////////////////////////////////////////////
//:: Death Script
//:: Based on NW_O0_DEATH.NSS
//:: 2001 Bioware Corp.
//:: Modified Jan 2006, B W-Husey
//:://////////////////////////////////////////////
/*
    This script handles the default behavior
    that occurs when a player dies. He can only respawn if
        1) He has a live henchmen
        2) The henchman is within 30 feet
*/
//:://////////////////////////////////////////////
//:: Created By: B W-Husey & Gale (DLA) (on Brent knowles base Bioware script)
//:: Modified On: Jan 2006, May 1st 2006
//:://////////////////////////////////////////////

#include "nw_i0_plot"
#include "cu_functions"

// modified by gaoneng erick
#include "dla_mel_inc2"
//#include "gao_mel_inc"
// end mod


// Reset reputation
void main()
{
    object oPlayer = GetLastPlayerDied();
    // we also pick up both henchmen to test if they are alive and not too far away, else PC can't respawn
    object oHench1 = ReturnHenchman(oPlayer,1);
    object oHench2 = ReturnHenchman(oPlayer,2);

    AssignCommand(oPlayer, ClearAllActions());

    // * make friendly to Each of the 3 common factions
    if (GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oPlayer) <= 10)
    {   SetLocalInt(oPlayer, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 80, oPlayer);
    }

    if (GetStandardFactionReputation(STANDARD_FACTION_MERCHANT, oPlayer) <= 10)
    {   SetLocalInt(oPlayer, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 80, oPlayer);
    }

    if (GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, oPlayer) <= 10)
    {   SetLocalInt(oPlayer, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 80, oPlayer);
    }

    //General Melee area death handling
    //It executes a custom code if the tag of the area matches the tag from melee fight area.
// modified by gaoneng erick
//    if (GetTag(GetArea(oPlayer)) == "dla_mel_area")
    if (GetTag(GetArea(oPlayer)) == DLA_ATAG_MELEEAREA)
    {
        AssignCommand(oPlayer, dla_EndMeleeTournament(oPlayer, FALSE));
//      AssignCommand(oPlayer, ClearAllActions());
//      DLA_EndFight(oPlayer);
// end mod
      return;
    }

    //Do we have a living, valid henchman?
    if (ReturnHenchman(oPlayer,1) != OBJECT_INVALID && GetDistanceBetween(oHench1,oPlayer)<30.0)
    {//Companion rescues us
    DelayCommand(2.5, PopUpDeathGUIPanel(oPlayer,TRUE,TRUE,0,"One of your companions has managed to drag you to safety...hit <RESPAWN>"));
    }
    //Do we have a living, valid henchman number 2 (i.e. first was out of range)?
    else if (ReturnHenchman(oPlayer,1) != OBJECT_INVALID && GetDistanceBetween(oHench1,oPlayer)<30.0)
    {//Companion rescues us
    DelayCommand(2.5, PopUpDeathGUIPanel(oPlayer,TRUE,TRUE,0,"One of your companions has managed to drag you to safety...hit <RESPAWN>"));
    }
    else
    { //we are dead, no respawn
    DelayCommand(2.5, PopUpDeathGUIPanel(oPlayer,FALSE,TRUE,0,"You have no surviving companions to rescue you. You must reload."));
    }
}




