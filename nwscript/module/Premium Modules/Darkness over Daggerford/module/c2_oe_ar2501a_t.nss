//::///////////////////////////////////////////////
//::
//:: a3_oe_ar2501a_t
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

void main()
{
    object oDoor = GetNearestObjectByTag("ar2501a_ar2500_exit");

    if (GetLocalInt(oDoor, "nBeenSealed") == 0)
    {
        object oEnterer = GetEnteringObject();
        if (GetIsPC(oEnterer))
        {
            object oDoorMan = GetNearestObjectByTag("bw_doorman", oDoor);

            if (GetIsObjectValid(oDoorMan))
            {
                effect eFX = EffectVisualEffect(VFX_FNF_LOS_EVIL_20);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX, oDoor);

                effect eGlow = EffectVisualEffect(VFX_DUR_GLOW_PURPLE);
                DelayCommand(0.2f, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGlow, oDoor));
                DelayCommand(0.3f, AssignCommand(oDoorMan, ActionCloseDoor(oDoor)));
                DelayCommand(0.5f, FloatingTextStringOnCreature("The door just closed!", oEnterer));

                SetLocalInt(oDoor, "nBeenSealed", 1);
            }
        }
    }
}
