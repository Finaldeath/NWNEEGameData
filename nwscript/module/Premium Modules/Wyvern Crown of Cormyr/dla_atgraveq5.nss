// January 2006
// B W-Husey
// Jenny Drabb tells the PC about the defaced grave.
// Found on Jenny not the Gravedigger.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "q5"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Set variable for PC or partywide
      AddJournalQuestEntry("Grave",45,oPC);
      if (GetLocalInt(oPC,"nGrave")<6) AllParty("nGrave",oPC,5);
      PartyGotEntry(sName,oPC,100,"XP Gain - Discovery");  //This comes with XP & message + sets the variable
    }

}


