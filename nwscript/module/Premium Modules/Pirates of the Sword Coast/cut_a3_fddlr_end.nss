//::///////////////////////////////////////////////
//:: cut_a3_fddlr_end
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    End script for the cutscene with the party
    arriving at Fiddler's Green.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: May 5, 2005
//:://////////////////////////////////////////////
#include "inc_undead"

void RemoveAllVFX(object oCreature);

void main()
{
    object oGarm = GetObjectByTag("a1_hench_garm");
    object oNisar = GetObjectByTag("a2_hench_nisar");
    RemoveAllVFX(oGarm);
    RemoveAllVFX(oNisar);

    ExecuteScript("exe_autosave", GetModule());
}

void RemoveAllVFX(object oCreature)
{
    effect e = GetFirstEffect(oCreature);
    while(GetIsEffectValid(e))
    {
        if(GetEffectType(e)==EFFECT_TYPE_VISUALEFFECT)
        {
            DelayCommand(0.01, RemoveEffect(oCreature, e));
        }
        e = GetNextEffect(oCreature);
    }
}
