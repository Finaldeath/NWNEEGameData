// January 2006
// B W-Husey
// Close the Piracy subquest with the correct details
// Found on Hawklin2 dialogue

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "Salv3Q9"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0,2.0);

    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,300,"XP Gain - Pirates defeated");  //This comes with XP & message + sets the variable
    if (GetLocalInt(oPC,"nPiracy") == 7)    AddJournalQuestEntry("Piracy",60,oPC,TRUE); //Update the journal - ship sunk
    if (GetLocalInt(oPC,"nPiracy") == 8)    AddJournalQuestEntry("Piracy",61,oPC,TRUE); //Update the journal - ship not sunk
    AllParty("nPiracy",oPC,9);                                    //Just sets variable (end quest)
    }

}


