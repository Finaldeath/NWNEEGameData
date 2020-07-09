//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Innovator sends player to arena fight
//::////////////////////////////////////////////////////
//:: This will also set up the camera
//::////////////////////////////////////////////////////

#include "hf_in_plot"
#include "cut_tm_arena_inc"


void setupCameraA(object oPC)
{
    AssignCommand(oPC, SetCameraFacing(110.0, 9.0, 50.0, CAMERA_TRANSITION_TYPE_SNAP));
    AssignCommand(oPC, StoreCameraFacing());
}


void setupCameraB(object oPC)
{
    AssignCommand(oPC, SetCameraFacing(90.0, 0.7, 89.0, CAMERA_TRANSITION_TYPE_SNAP));
    SetCameraHeight(oPC, 1.8);
}


void RemovePolymorphEffects(object oPC)
{
    effect eEffect = GetFirstEffect(oPC);
    while (GetIsEffectValid(eEffect))
    {
        if (GetEffectType(eEffect) == EFFECT_TYPE_POLYMORPH)
        {
            RemoveEffect(oPC, eEffect);
        }
        eEffect = GetNextEffect(oPC);
    }
}


void main()
{
    object oPC = GetPCSpeaker();
    object oWaypoint = GetObjectByTag(WP_TAG_PLAYER_INIT);

    FadeToBlack(oPC, FADE_SPEED_MEDIUM);
    // Prepare camera for cutscene to prevent weirdness in the narrow corridor
    DelayCommand(2.0, setupCameraA(oPC));
    DelayCommand(3.0, setupCameraB(oPC));

    DelayCommand(3.9, RemovePolymorphEffects(oPC));
    DelayCommand(4.0, AssignCommand(oPC, JumpToObject(oWaypoint)));
}
