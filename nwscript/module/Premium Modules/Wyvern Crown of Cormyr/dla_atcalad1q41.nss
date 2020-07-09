// January 2006
// B W-Husey
// Updates 'The Ring' journal entry
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "j41"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    AddJournalQuestEntry("QRing",41,oPC,TRUE);                      //Update the journal

    }

}


