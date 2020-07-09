// Direct summoning ceremony in Kur-Tharsu Upper Floor

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "inc_ktgate"

void main()
{
    object oMaganus = GetLocalObject(OBJECT_SELF, "oMaganus");
    object oOgre1 = GetLocalObject(OBJECT_SELF, "oOgre1");
    object oOgre2 = GetLocalObject(OBJECT_SELF, "oOgre2");
    object oOgre3 = GetLocalObject(OBJECT_SELF, "oOgre3");
    object oOgre4 = GetLocalObject(OBJECT_SELF, "oOgre4");
    object oPC = GetFirstPC();

    effect eOgre;
    effect ePortal;

    if(GetIsObjectValid(oOgre1) && PlotLevelGet("OgreAnimation") == 1)
    {
        AssignCommand(oOgre1, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 5.0));
        AssignCommand(oOgre2, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 5.0));
        AssignCommand(oOgre3, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 5.0));
        AssignCommand(oOgre4, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 5.0));
    }

    //Change Ogre and Portal vfx according to Maganus' health (without backtracking if healed)
    //When Maganus is reduced to 1 hit point, execute the Orcus Summon cutscene
    if(GetIsObjectValid(oMaganus)&& !IsInConversation(oMaganus))
    {
        int nCurrHP = GetCurrentHitPoints(oMaganus);
        int nMaxHP = GetMaxHitPoints(oMaganus);

        float fHealth =  100 * (IntToFloat(nCurrHP) / IntToFloat(nMaxHP));

        object oPortal = GetNearestObjectByTag("OrcusPortal");

        if(nCurrHP == 1)
        {
            PlotLevelSet("MaganusHealth", 4);

            if(GetLocalInt(OBJECT_SELF, "nCutscenePlayed") == 0 &&
               GetCurrentHitPoints(oPC) > 0 && !GetIsDead(oPC) &&
               !GetHasEffect(EFFECT_TYPE_TIMESTOP, oPC) &&
               !GetHasEffect(EFFECT_TYPE_TIMESTOP, oMaganus))
            {
                //Play the Orcus summoning cutscene
                SetLocalInt(OBJECT_SELF, "nCutscenePlayed", 1);
                CutscenePlay(oPC, "cut_tm_ktorcus");
            }
        }
        else if(fHealth < 25.0 || PlotLevelGet("MaganusHealth") == 3)
        {
            if(PlotLevelGet("MaganusHealth") < 3)
            {
                eOgre = EffectVisualEffect(VFX_DUR_PROT_EPIC_ARMOR);
                ApplyOgreEffects(eOgre);
            }

            PlotLevelSet("MaganusHealth", 3);
            ePortal = EffectVisualEffect(VFX_FNF_PWKILL);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, ePortal, oPortal);
        }
        else if(fHealth < 50.0 || PlotLevelGet("MaganusHealth") == 2)
        {
            if(PlotLevelGet("MaganusHealth") < 2)
            {
                eOgre = EffectVisualEffect(VFX_DUR_MAGIC_RESISTANCE);
                ApplyOgreEffects(eOgre);
            }

            PlotLevelSet("MaganusHealth", 2);
            ePortal = EffectVisualEffect(VFX_FNF_WORD);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, ePortal, oPortal);
        }
        else if(fHealth < 75.0 || PlotLevelGet("MaganusHealth") == 1)
        {
            if(PlotLevelGet("MaganusHealth") < 1)
            {
                eOgre = EffectVisualEffect(VFX_DUR_SPELLTURNING);
                ApplyOgreEffects(eOgre);
            }

            PlotLevelSet("MaganusHealth", 1);
            ePortal = EffectVisualEffect(VFX_FNF_LOS_EVIL_30);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, ePortal, oPortal);
        }
    }
}
