//::///////////////////////////////////////////////
//:: ten_a2_temportal
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    When active, makes entering object "portal"
    out, if said object is Tasina or a
    priestess.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 17/05
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    // Only act if the portal is active. In theory, Tasina and the
    // priestesses should never walk into this trigger until it's
    // active anyway, but it's good to do just in case.
    if(GetLocalInt(OBJECT_SELF, l_n_A2_TEMPLE_PORTAL_OUT_ACTIVE))
    {
        object oEnter = GetEnteringObject();
        string sTag = GetTag(oEnter);
        if( (sTag == a2c_tag_Tasina) ||
            (sTag == a2c_tag_Priestess) ||
            (sTag == a2c_tag_Sahuagin_Cleric) ||
            (sTag == a2c_tag_Sahuagin_Guard) )
        {
            if(!GetLocalInt(oEnter, l_n_A2_TEMPLE_STAYING_TO_FIGHT) ||
                GetLocalInt(GetArea(OBJECT_SELF), "nNextCutscene") == 2) // 2 = tas2 cutscene
            {
                effect eVFX1 = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
                effect eVFX2 = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX1, oEnter);
                DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX2, oEnter));
                DestroyObject(oEnter, 3.0);
            }
        }
    }
}
