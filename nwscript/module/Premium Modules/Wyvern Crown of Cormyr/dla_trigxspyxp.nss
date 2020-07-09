// November 2005
// B W-Husey
// NPC rewards template to be used after an action - used for secret door trigger of To be a Spy quest
// This is on the OnExit event in case the PC uses the secret door.

#include "cu_functions"
void main()
{
object oPC = GetExitingObject();

//Pick Variable Type and rename

int nResult = GetLocalInt(oPC,"nSpy");

//Give rewards once only
if (nResult ==2)
    {
    AddJournalQuestEntry("Spy",20,oPC,TRUE);                      //Update the journal with failure
    DestroyObject(OBJECT_SELF);
    }
if (nResult ==3)
    {
    AddJournalQuestEntry("Spy",21,oPC,TRUE);                      //Update the journal with success
    DestroyObject(OBJECT_SELF);
    }
if (nResult >3)
    {
    DestroyObject(OBJECT_SELF);                               //Not needed, remove
    }
}


