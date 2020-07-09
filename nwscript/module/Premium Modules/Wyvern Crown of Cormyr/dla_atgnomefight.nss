// April 2004
// B W-Husey
// NPC rewards template to be used after an action
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "KillGn"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    AllParty(sName,oPC,2);                                    //Just sets variable
    // Journal entry only if all the relevant info is known.
    if (GetLocalInt(oPC,"nGnomeknow")==1 && GetLocalInt(oPC,"nRevenge")==1) AddJournalQuestEntry("Revenge",16,oPC,TRUE);                      //Update the journal
  ScoreAlign(oPC,1,0,0,0,0,1,1,1,1,1);            //Who gets alignment points for this
    }

}


