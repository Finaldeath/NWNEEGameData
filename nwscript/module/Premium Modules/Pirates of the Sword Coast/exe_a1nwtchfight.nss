//::///////////////////////////////////////////////
//:: exe_a1nwtchfight
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script stops the player from watching the
    Garm arena fight and sends them back to the
    cell.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "_inc_generic"

void RemoveInvis (object oPC);

void main()
{
    object oPC = OBJECT_SELF;
    object oCell = GetWaypointByTag("a1_trogcell");
    location lCell = GetLocation(oCell);
    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);

    SetLocalInt(oPC, "A1_WATCHING_FIGHT", FALSE);
    FadeToBlack(oPC);

    // remove effects, end the cutscene mode, and send him back
    DelayCommand(1.0f, SetCutsceneMode(oPC, FALSE));
    DelayCommand(1.0f, RemoveInvis(oPC));
    DelayCommand(1.1f, AssignCommand(oPC, ClearAllActions(TRUE)));
    DelayCommand(1.2f, JumpPCsToLocation(lCell, 0, oPC));
    DelayCommand(1.5f, FadeFromBlack(oPC));
}

void RemoveInvis (object oPC)
{
    effect eEffect = GetFirstEffect(oPC);

    while (GetIsEffectValid(eEffect) == TRUE)
    {
        if((GetEffectType(eEffect) == EFFECT_TYPE_VISUALEFFECT)
          || (GetEffectType(eEffect) == EFFECT_TYPE_CUTSCENEIMMOBILIZE))
        {
            DelayCommand(0.1f, RemoveEffect(oPC, eEffect));
        }

        eEffect = GetNextEffect(oPC);
    }
}
