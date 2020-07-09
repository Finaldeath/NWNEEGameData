//::///////////////////////////////////////////////
//::
//:: a3_oe_ar2501a_t2
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Enter script for area.
//::
//:: Seals the entrance to Illefarn behind the player.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 9/21/2005
//::
//:://////////////////////////////////////////////

#include "nw_i0_spells"

void main()
{
    object oEnterer = GetEnteringObject();
    object oDoor = GetNearestObjectByTag("ar2501a_ar2500_exit");

    if (GetIsPC(oEnterer))
    {
        if (GetLocalInt(oDoor, "nBeenSealed") == 0)
        {
            object oDoorMan = GetNearestObjectByTag("bw_doorman", oDoor);

            if (GetIsObjectValid(oDoorMan))
            {
                SetLocalInt(oDoor, "nBeenSealed", 1);

                AssignCommand(oEnterer, ClearAllActions());

                effect eFX = EffectVisualEffect(VFX_FNF_LOS_EVIL_20);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX, oDoor);

                effect eGlow = EffectVisualEffect(VFX_DUR_GLOW_PURPLE);
                DelayCommand(0.2f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGlow, oDoor));
                DelayCommand(0.3f, AssignCommand(oDoorMan, ActionCloseDoor(oDoor)));
                DelayCommand(0.5f, FloatingTextStringOnCreature("The door just closed!", oEnterer));
            }
        }
        else
        {
            if (GetLocalInt(oEnterer, "nIH_KnowsExit") == 1)
            {
                if (GetLocked(oDoor))
                {
                    SetLocalInt(oDoor, "nNoFeedback", 1);

                    AssignCommand(oEnterer, ClearAllActions());

                    RemoveSpecificEffect(EFFECT_TYPE_VISUALEFFECT, oDoor);

                    object oDoorman = GetNearestObjectByTag("bw_doorman", oDoor);
                    FloatingTextStringOnCreature("Black bones...", oEnterer);

                    AssignCommand(oDoorman, ActionWait(1.0f));
                    effect eFX = EffectVisualEffect(VFX_FNF_LOS_EVIL_20);
                    AssignCommand(oDoorman, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX, oDoor));
                    AssignCommand(oDoorman, ActionDoCommand(SetLocked(oDoor, FALSE)));
                    AssignCommand(oDoorman, ActionOpenDoor(oDoor));
                    return;
                }
            }
        }
    }
}
