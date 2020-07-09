// B W-Husey
// October 2005
// Tag-Based Item Script for the silver mirrors.
// This test where the mirror was put down and applies an appropriate effect if required.

/*
    SILVERMIRROR.nss
    tag-based item script for Silver Mirror
    "gaoneng" Erick            March 27, 2006

    replaced mirror placeable creation code
*/


#include "x2_inc_switches"
#include "cu_puzzles"

int GetTagBasedItemEventNumber()
{
    int nEvent = GetLocalInt( OBJECT_SELF, "X2_L_LAST_ITEM_EVENT");
    return (nEvent ? nEvent : GetLocalInt( GetModule(), "X2_L_LAST_ITEM_EVENT"));
}

void SetTagBasedScriptExitBehavior( int nEndContinue)
{
    DeleteLocalInt( OBJECT_SELF, "X2_L_LAST_ITEM_EVENT");
    DeleteLocalInt( GetModule(), "X2_L_LAST_ITEM_EVENT");
    SetExecutedScriptReturnValue( nEndContinue);
}

void main()
{
    switch(GetTagBasedItemEventNumber())
    {
//        case X2_ITEM_EVENT_ACQUIRE:
//        {   // This is where you would process item acquired - sets journal
//            // Acquiring this item closes off/updates several plots, including the main one to 6.
//            object oPC = GetModuleItemAcquiredBy();
//            object oItem = GetModuleItemAcquired();
//        }
        case X2_ITEM_EVENT_UNACQUIRE:
        {
// Erick - March 27, 2006
// replaced chunk
            gn_PlaceMirror(GetModuleItemLostBy(), GetModuleItemLost());
//            object oPC = GetModuleItemLostBy();
//            object oItem = GetModuleItemLost();
//            object oMirror; // Erick sez - unused variable
//            object oNew = CreateObject(OBJECT_TYPE_PLACEABLE,"silvermirror_plc",GetLocation(oPC),FALSE);
//            AssignCommand(oNew, DelayCommand(1.5,MirrorCheck(oPC)));
//            DestroyObject(oItem, 0.2); // Erick sez - delay serves no purpose
            SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_END); // Erick sez - preserved from old script, not sure what this does...
            break;
        }
        default : SetTagBasedScriptExitBehavior( X2_EXECUTE_SCRIPT_CONTINUE); break; // Erick sez - and this too...
    }
}
