// April 2004
// B W-Husey
// NPC rewards template to be used after an action
// Found on Huntcrown, this sets the Ride like a centaur variable to 2 (can't get the oath)
// Updates Ride journal, rewards xp.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "HOathd"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

        AllParty("nManthia1Side",oPC,2); //Update ride Like a centaur quest - not completable
        AddJournalQuestEntry("Centaur",51,oPC,TRUE);                      //Update the journal
    }

}


