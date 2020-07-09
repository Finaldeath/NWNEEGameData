// April 2004
// B W-Husey
// NPC rewards template to be used after an action
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "j30"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    AddJournalQuestEntry("QRing",30,oPC,TRUE);                      //Update the journal

    }

}


