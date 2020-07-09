//::///////////////////////////////////////////////
//:: Name x2_def_userdef
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On User Defined Event script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////
#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;
void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    {

    }
    else if(nUser == EVENT_PERCEIVE) // PERCEIVE
    {

    }
    else if(nUser == EVENT_END_COMBAT_ROUND) // END OF COMBAT
    {

    }
    else if(nUser == EVENT_DIALOGUE) // ON DIALOGUE
    {

    }
    else if(nUser == EVENT_ATTACKED) // ATTACKED
    {
        //If attacked and not hostile, turn hostile and attack
        if(GetLocalInt(GetModule(), "render") == 0)
        {
            SignalEvent(GetObjectByTag("munroe_helper"), EventUserDefined(5401));
        }
    }
    else if(nUser == EVENT_DAMAGED) // DAMAGED
    {
       //If any are damaged, set the int to indicate non-peaceful resolution
       SetLocalInt(GetModule(), "render", 2);
       if(GetLocalInt(GetModule(), "mayor_wilsey") == 2)
       {
           AddJournalQuestEntry("j7",4,GetFirstPC());
       }

       int iMaximumHP = GetMaxHitPoints();
       int iCurrentHP = GetCurrentHitPoints();
       if (iCurrentHP < (iMaximumHP / 2))
       {
           /*ClearAllActions(TRUE);
           ActionMoveToObject(GetObjectByTag("wp_munroe"), TRUE);
           ActionDoCommand(DestroyObject(OBJECT_SELF));
           SetCommandable(FALSE);*/
           ClearAllActions(TRUE);
           //ExecuteScript("hf_cs_exit", OBJECT_SELF);
           ActionMoveToObject(GetObjectByTag("wp_munroe"), TRUE);
           ActionDoCommand(DestroyObject(OBJECT_SELF));
           SetCommandable(FALSE);
           if(GetTag(OBJECT_SELF) == "db_jethromunroe")
           {
               SignalEvent(GetObjectByTag("munroe_helper"), EventUserDefined(5400));
           }
       }
    }
    else if(nUser == 1007) // DEATH  - do not use for critical code, does not fire reliably all the time
    {

    }
    else if(nUser == EVENT_DISTURBED) // DISTURBED
    {

    }
    else if (nUser == EVENT_USER_DEFINED_PRESPAWN)
    {

    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
    }
}
