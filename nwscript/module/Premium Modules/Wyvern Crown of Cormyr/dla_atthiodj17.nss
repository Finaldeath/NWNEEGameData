// January 2006
// B W-Husey
// PC shows Thiodor Imelda's note.
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XPInoteT"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    AddJournalQuestEntry("Revenge",17,oPC,TRUE);                      //Update the journal

    }

}


