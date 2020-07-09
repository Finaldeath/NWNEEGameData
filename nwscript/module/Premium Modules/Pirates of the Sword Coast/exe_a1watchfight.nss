//::///////////////////////////////////////////////
//:: exe_a1watchfight
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script Starts the player watching the
    Garm arena fight.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oPC = OBJECT_SELF;
    object oCamera = GetWaypointByTag("a1_fightcam");

    effect eImmobile = EffectCutsceneImmobilize();
    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);

    eImmobile = ExtraordinaryEffect(eImmobile);

    SetLocalInt(oPC, "A1_WATCHING_FIGHT", TRUE);
    SetCutsceneMode(oPC, TRUE);

    AssignCommand(oPC, JumpToObject(oCamera, FALSE));
    AssignCommand(oPC, SetCameraFacing(20.0f, 13.0f, 70.0f, CAMERA_TRANSITION_TYPE_SNAP));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oPC);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmobile, oPC);

    FadeFromBlack(oPC, FADE_SPEED_MEDIUM);
}
