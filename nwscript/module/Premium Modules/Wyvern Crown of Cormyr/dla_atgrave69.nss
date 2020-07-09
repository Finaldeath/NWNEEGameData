// January 2006
// B W-Husey
// NPC rewards template to be used after an action
// New gravestone ordered: pay 5 gold, set variable and journal entries.
// Completion alignment scores are handled in revenge section (4) and here (1)
// Everyone gets a point for new gravestone

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "GFix"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0);


    // Remove from the player
    TakeGoldFromCreature(5, GetPCSpeaker(), FALSE);

    //Alignment consequences of action
    AligXP("AligGFix", oPC, "GOOD", 50, 0);        //Shift/reward any alignment
    AligXP("AligGFix2", oPC, "LAWFUL", 25, 0);        //Shift/reward any alignment

    //Set variable for PC or partywide
    if (GetLocalInt(oPC,"nGrave")==5) //Case: culprit not found
    {
        AllParty("nGrave",oPC,6);
        PartyGotEntry(sName,oPC,100,"XP Gain - father rests easier");  //This comes with XP & message + sets the variable
        AddJournalQuestEntry("Grave",50,oPC,TRUE);                      //Update the journal
    }
    if (GetLocalInt(oPC,"nGrave")==7) //Case: culprit already found
    {
        AllParty("nGrave",oPC,9);
        PartyGotEntry(sName,oPC,5000,"XP Gain - Quest completed");  //This comes with XP & message + sets the variable
        AddJournalQuestEntry("Grave",76,oPC,TRUE);                      //Update the journal
    }
        ScoreAlign(oPC,1,1,1,1,1,1,1,1,1,1);            //Who gets alignment points for this
    }

}


