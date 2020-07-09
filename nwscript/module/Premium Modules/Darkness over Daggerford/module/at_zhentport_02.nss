// player opens portal to escape from illefarn

#include "x0_i0_position"

void OpenPortal(location lLocation)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, "bw_portal", lLocation, FALSE, "ar2504_portal");
}

void main()
{
    object oMe = OBJECT_SELF;
    object oPC = GetPCSpeaker();

    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionMoveToObject(oMe, FALSE, 0.3));
    AssignCommand(oPC, ActionDoCommand(TurnToFaceObject(oMe, oPC)));
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 1.8));

    effect eFX = EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MAJOR);
    DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFX, OBJECT_SELF, 2.0));

    object oWP = GetNearestObjectByTag("wp_ar2504_porter");
    location lLoc = GetLocation(oWP);

    effect eFire = EffectVisualEffect(VFX_IMP_HARM);
    DelayCommand(2.6, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFire, lLoc));

    DelayCommand(3.0, OpenPortal(lLoc));
}
