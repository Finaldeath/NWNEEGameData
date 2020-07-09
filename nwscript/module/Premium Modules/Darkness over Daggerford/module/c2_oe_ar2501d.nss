// onEnter event for AR2501D (Hall of Wonders in Illefarn)
// .. make some vfx

#include "hf_in_spawn"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nEntered") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nEntered", 1);

            // make some webs in the spider's nest
            int i = 0;
            object oWeb = GetObjectByTag("PL_AR2501D_WEB", i);
            while (GetIsObjectValid(oWeb))
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_WEB_MASS), oWeb);
                oWeb = GetObjectByTag("PL_AR2501D_WEB", ++i);
            }

            // make the loot pedestals glow
            for (i=1; i<=6; i++)
            {
                object oPedestal = GetObjectByTag("ks_ar2501d_pedestal"+IntToString(i));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_PROTECTION_GOOD_MINOR), oPedestal);
            }
        }

        SpawnEnter(oPC);
    }
}
