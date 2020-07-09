// May 1st 2006
// B W-Husey
// This trigger sets the state of the Careless Master quest (as the previous one seems to have been deleted)

#include "cu_functions"
// for custom functions

void main()
{
    object oPC = GetEnteringObject();
    object oArea = GetArea(OBJECT_SELF);
    if (GetIsDefPC(oPC))
    {
        //Check if quest is already active, message the PC and destroy the trigger
/*        if (GetLocalInt(oPC,"nCareActive")>0)
        {
            if (GetLocalInt(oArea,"nDefended")==1)
            {
            FloatingTextStringOnCreature("Your horse has been disturbed",oPC);
            AddJournalQuestEntry("Careless",11,oPC);
            }
            if (GetLocalInt(oArea,"nDefended")==2)
            {
            FloatingTextStringOnCreature("Your horse has been stolen",oPC);
            AddJournalQuestEntry("Careless",10,oPC);
            }
            DestroyObject(OBJECT_SELF);
        }
        else // if not activate quest
*/
        if (GetLocalInt(oPC,"nCareActive")<1)
        SetLocalInt(oPC,"nCareActive",1);
    }
}
