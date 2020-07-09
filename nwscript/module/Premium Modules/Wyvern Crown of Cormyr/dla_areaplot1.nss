// B W-Husey
// October 2005
// The Main plot variable is set to 1, to denote we have started the module. I have set this on the OnEnter event
// of the first area (can be moved if need be), so if you are not testing this area, skip it to leave the variable unset.
// This script also levels up the PC and strips them of all but hunting equipment, adds the henchmen
// Changes Jonas' race to match PC.

#include "cu_functions"
//include the library for variable setting command AllParty()
#include "x0_i0_henchman"
#include "dla_i0_horse"
#include "NW_I0_GENERIC"

void main()
{
    object oPC = GetEnteringObject();
    location lLoc = GetLocation(GetWaypointByTag("WP_JonStart"));
    SetLocalInt(OBJECT_SELF,"sOff",1);
//============================================================
    if (GetIsDefPC(oPC) && GetLocalInt(oPC,"nModStarted")==0)  //Change if you want multiplayer
    {
    // Add journal entries
        AllParty("nMainPlot",oPC,1);
        DeleteLocalInt(oPC, "dla_joust_state");
        AddJournalQuestEntry("MainPlot",10,oPC,TRUE);
        AddJournalQuestEntry("Background",1,oPC,TRUE);
        AddJournalQuestEntry("Notes",1,oPC,TRUE);
        AddJournalQuestEntry("Henchmen",1,oPC,TRUE);
        JonasRace(GetRacialType(oPC),lLoc);
        CreateObject(OBJECT_TYPE_CREATURE,"godfroy",lLoc,FALSE);

    //====This section recruits the henchmen========
    object oHench1 = GetNearestObjectByTag("Jonas",oPC);
    object oHench2 = GetNearestObjectByTag("Godfroy",oPC);
    AssignCommand(oHench1,ActionMoveToObject(oPC,FALSE,1.5));
    SetLocalInt(oHench1, "X0_L_LEVELRULES",0);
    SetLocalInt(oHench2, "X0_L_LEVELRULES",0);
    DLA_SetHenchman(oHench1, oPC);   //switched from HireHenchman for multi hench - check this
    DLA_SetHenchman(oHench2, oPC);   //switched from HireHenchman for multi hench - check this
    SetDidQuit(oPC, oHench1, FALSE);
    SetDidQuit(oPC, oHench2, FALSE);
    //switch off chest bashing else they may block PC in a corner in the burnt farmhouse
    SetAssociateState(NW_ASC_RETRY_OPEN_LOCKS, FALSE, oHench1);
    SetAssociateState(NW_ASC_RETRY_OPEN_LOCKS, FALSE, oHench2);
    // Turn on standard henchman listening patterns
    SetAssociateListenPatterns(oHench1);
    SetAssociateListenPatterns(oHench2);
    LevelUpXP1Henchman(oPC);
    DLA_RefreshMovementSpeed(oHench1);
    DLA_RefreshMovementSpeed(oHench2);

     //===set deity == choices limited to those with specific items
     if (GetDeity(oPC) =="") // PC forgot to pick a deity
     {
        string sGod;
        if (GetAlignmentGoodEvil(oPC)==ALIGNMENT_EVIL)
        {
            if (GetAlignmentLawChaos(oPC)==ALIGNMENT_LAWFUL) sGod = "Silvanus";
            else sGod = "Malar";
        }
        else if (GetAlignmentGoodEvil(oPC)==ALIGNMENT_GOOD)
        {
            if (GetAlignmentLawChaos(oPC)==ALIGNMENT_LAWFUL) sGod = "Tyr";
            else if (GetAlignmentLawChaos(oPC)==ALIGNMENT_CHAOTIC) sGod = "Selune";
            else sGod = "Lathander";
        }
        else
        {
            if (GetAlignmentLawChaos(oPC)==ALIGNMENT_LAWFUL) sGod = "Helm";
            else if (GetAlignmentLawChaos(oPC)==ALIGNMENT_CHAOTIC) sGod = "Silvanus";
            else sGod = "Silvanus";
        }
        SetDeity(oPC,sGod);
        FloatingTextStringOnCreature("Deity set to "+sGod,oPC,FALSE);
     }


    //=========Next section stips the PC of equipment.==========
        int     PLAYER_STRIPS   = TRUE;
        if (PLAYER_STRIPS)
        {
        ExecuteScript("dla_miscstrip",oPC);
        DelayCommand(0.2,ExecuteScript("dla_miscequip",oPC));
        }

    // Make Jonas the same race
    // SWITCH THIS OVER TO CREATING FROM TEMPLATE XXXXXXXXXXXXXXXXXXXXXX
//    SetCreatureAppearanceType(oHench1,GetAppearanceType(oPC));

    //Next section deals with levelling the PC to the correct level (minimum lvl 6)
    // and warns over-level players not to continue.
        if (GetXP(oPC)< 15000) SetXP(oPC,15000);
        else if (GetXP(oPC)> 25000)
        {
            FloatingTextStringOnCreature("This module is designed for new characters...",oPC);
            FloatingTextStringOnCreature("... starting with characters above level 6 is NOT recommended.",oPC);
        }
        SetLocalInt(oPC,"nModStarted",1);
    }
}




