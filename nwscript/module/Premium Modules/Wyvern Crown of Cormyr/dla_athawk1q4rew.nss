// B W-Husey
// October 2005
//
// This script updates the state of Hawklin's Plot variable used in section 1 of the module (see plot doc)
// to state 4 (next conversation at Hawklin castle). This also moves the current incidence of Hawklin to the edge
// of the area and destroys him. The variable set is nHawklin1, and while in state 4 (i.e. this state)
// it also opens Hawklin Castle where the next incidence of Hawklin awaits.
// An xp reward and journal update is also generated.
//if the PC borrowed a horse from Lacinda, her dialogue is triggered.

#include "cu_functions"

void main()
{
    //Define variable used
    location lLoc = GetLocation(GetWaypointByTag("WP_TTGWest1"));
    object oPC = GetPCSpeaker();
    object oLac = GetNearestObjectByTag("Lacinda");
    string sName = "XPHawklin14"+GetTag(OBJECT_SELF); //Unique variable for rewards - not re-used.

    //Give rewards and set variables once only, as this script is re-used if the PC re-interrupts Hawklin as he exits.
    if (GetLocalInt(oPC,sName)<1) //once only
    {
        //Set variable for PC or partywide
        PartyGotEntry(sName,oPC,500, "XP gain - Sir Gilbert Hawklin convinced");  //Reward whole party TrapXPGain/2 for trap removal, tell all party members what XP is for, and set the variable so the XP cannot be gained again.
        //set the crucial plot variable used in section 1
        AllParty("nHawklinPlot1",GetPCSpeaker(),4);
        AddJournalQuestEntry("Hawklin1",40,oPC);
        // Now get rid of this incidence of Hawklin
        DestroyObject(OBJECT_SELF,20.0);
    }
    //Move Hawklin each and every time the PC tries to have another dialogue.
    DelayCommand(2.0,ActionMoveToLocation(lLoc,FALSE));
    //If Lacinda leant a horse, fire her return dialogue.
    if(HasItemByTag(oPC,"LadysFavor"))
    {
        AllParty("nLady",oPC,2); //PC is ready to return the horse
        AssignCommand(oLac,ActionStartConversation(oPC,"Lacinda",FALSE,FALSE));
    }
}











