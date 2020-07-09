// January 2006
// B W-Husey
// PC has let Latim and Eleanor go. Update journal and alignment choices (favours chaotic)

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "q2"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Set variable for PC or partywide
    AllParty("nAbduct",oPC,2);                                    //Just sets variable
    PartyGotEntry(sName,oPC,100,"XP Gain - quest experience");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Abduct",20,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,2,1,2,2,1,2,2,1,2,2);            //Who gets alignment points for this
    }

}


