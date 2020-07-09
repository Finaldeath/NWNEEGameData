// March 2006
// B W-Husey
// Set the nGrave variable to reflect that the crime has been reported.
// 7 = reported only, 9 = completed (i.e. got a new grave too)
// nHandOver = 1, no more badknight dialogues
// Alignment consequences - everyone does ok (but lawful do better by reporting it)

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "grave79"+GetTag(OBJECT_SELF);                     //Unique tag
int nGrave = GetLocalInt(oPC,"nGrave");
//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Alignment consequences of action (doing what you should points in this case!)
    AligXP("AligGFix3", oPC, "LAWFUL", 100, 0);        //Shift/reward any alignment

    //Set variable for PC or partywide
        if (nGrave == 6)     //PC already ordered a grave
        {
            AllParty("nGrave",oPC,9);                                    //Quest completed
            PartyGotEntry(sName,oPC,500,"XP Gain - father rests peacefully");  //This comes with XP & message + sets the variable
            AddJournalQuestEntry("Grave",75,oPC,TRUE);                      //Update the journal
        }
        else if (nGrave == 5) //PC has not ordered a grave and also needs to do that
        {
            AllParty("nGrave",oPC,7);
            PartyGotEntry(sName,oPC,100,"XP Gain - father rests easier");        //Just sets variable
            AddJournalQuestEntry("Grave",65,oPC,TRUE);                      //Update the journal
        }
        AllParty("nHandOver",oPC,1);
        ScoreAlign(oPC,4,4,4,2,4,4,2,4,4,2);            //Who gets alignment points for this
        GiveKnightReputation(oPC,"the Just");
    }

}


