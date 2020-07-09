// Syrsnein, 26 April 2006: Modified to signal an event to start the barrow
//  battlefield escape cutscene.

//include "dla_i0_battle"
#include "dla_i0_const"

void main()
{

    object oPC = GetLocalObject(GetArea(OBJECT_SELF), "oPC");

    if (GetLocalInt(OBJECT_SELF, "Battlefield") == 1 && GetIsObjectValid(oPC) && !GetLocalInt(oPC, "nBattleOver") && (GetCurrentHitPoints(OBJECT_SELF) < GetMaxHitPoints(OBJECT_SELF)/3))
    {
        object oDirector = GetObjectByTag("SceneDirector");
//          DoWLLeavingCutscene(oPC);
        SignalEvent(oDirector, EventUserDefined(DLA_EVENT_BARROWEXIT));
    }
    else
        ExecuteScript("x0_ch_hen_damage", OBJECT_SELF);
}
