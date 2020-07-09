//::///////////////////////////////////////////////
//:: dla_trigbeamstar
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Area OnEnter script that activates the beams and triggers of the beam puzzle
   in the Wyvernwater Castle: Through the Portal area.
*/
//:://////////////////////////////////////////////
//:: Create By: B W-Hughes
//:: Created On: January, 2006
//:://////////////////////////////////////////////
//:: Modified:
//:: Syrsnein - 5 April 2006, Rewrote the script and removed the old code after
//::    debugging and ensuring everything works.

#include "dla_i0_const"

void main()
{
    if (!GetIsPC(GetEnteringObject())) return;
    SetLocalInt(OBJECT_SELF, "bPuzzleActive", TRUE);
    int i;
    for (i=1;i<5;i++)
    {
        object oTrigger   = GetObjectByTag("CWPTrigger" + IntToString(i));
        SignalEvent(oTrigger, EventUserDefined(DLA_EVENT_DEATHBEAM_ON));
    }
}
