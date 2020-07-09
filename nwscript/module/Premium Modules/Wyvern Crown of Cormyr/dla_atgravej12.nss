// April 2004
// B W-Husey
// NPC rewards template to be used after an action
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "KnowLic";                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    AllParty(sName,oPC,1);
        if(GetLocalInt(GetPCSpeaker(), "nGrave") == 1)    AddJournalQuestEntry("Grave",12,oPC,TRUE);                      //Update the journal
    }

}


