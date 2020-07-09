// Syrsnein, 26 April 2006: Modified to signal an event to start the barrow
//  battlefield escape cutscene.

//include "dla_i0_battle"
#include "dla_i0_const"

void main()
{
    object oPC = GetLocalObject(GetArea(OBJECT_SELF), "oPC");

    if (GetIsObjectValid(oPC) && !GetLocalInt(oPC, "nBattleOver") && (GetCurrentHitPoints(OBJECT_SELF) < GetMaxHitPoints(OBJECT_SELF)/3))
    {
        object oDirector = GetObjectByTag("SceneDirector");

//          DoWLLeavingCutscene(oPC);
        SignalEvent(oDirector, EventUserDefined(DLA_EVENT_BARROWEXIT));
    }
    else
        ExecuteScript("x2_def_ondamage", OBJECT_SELF);
}
