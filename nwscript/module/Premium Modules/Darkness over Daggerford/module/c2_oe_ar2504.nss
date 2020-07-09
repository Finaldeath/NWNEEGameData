//::///////////////////////////////////////////////
//::
//:: c2_oe_ar2504
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Enter script for area.
//::
//:: Update journal.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 10/17/2005
//::
//:://////////////////////////////////////////////

#include "hf_in_spawn"
#include "hf_in_xp"

void main()
{
   object oEnterer = GetEnteringObject();

    if (GetIsPC(oEnterer))
    {
        SpawnEnter(oEnterer);

        // apply VFX to the area objects
        if (GetLocalInt(OBJECT_SELF, "nEntered") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nEntered", 1);
            object oBall = GetObjectByTag("ar2504_cball");
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_LIGHT_RED_5), oBall);
        }
    }
}
