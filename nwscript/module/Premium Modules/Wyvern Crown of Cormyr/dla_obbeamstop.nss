//::///////////////////////////////////////////////
//:: dla_obbeamstop
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Temporarily deactivates the beams and triggers of the beam puzzle in the
   Wyvernwater Castle: Through the Portal area.
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
    object oPC = GetLastUsedBy();

    //lever animation
    PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    DelayCommand(1.0, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));

    int i;
    for (i=1;i<5;i++)
    {
        int nTimer = 10;
        switch (i)
        {
            case 2: nTimer +=  3; break;
            case 3: nTimer += 15; break;
            case 4: nTimer += 25; break;
        }

        object oTrigger = GetObjectByTag("CWPTrigger" + IntToString(i));
        SetLocalInt(oTrigger, "nTimer", nTimer);
        SignalEvent(oTrigger, EventUserDefined(DLA_EVENT_DEATHBEAM_OFF));
        DelayCommand(0.1, SignalEvent(oTrigger, EventUserDefined(DLA_EVENT_DEATHBEAM_ON)));
    }
}

