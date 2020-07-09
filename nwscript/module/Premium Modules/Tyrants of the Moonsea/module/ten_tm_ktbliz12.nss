//PC arrives at Kur-Tharsu Gate so set plot variables on Blizzard and Elf
#include "nw_i0_spells"

#include "hf_in_plot"

//Remove any effects from Blizzard's Invisibility Sphere spell
void RemoveInvisibilitySphere(object oEntering, object oCaster)
{
    effect eAOE = GetFirstEffect(oEntering);

    //Search through the valid effects on the target.
    while (GetIsEffectValid(eAOE))
    {
        if(GetTag(GetEffectCreator(eAOE)) == "Blizzard")
        {
            if(GetEffectType(eAOE) == EFFECT_TYPE_INVISIBILITY)
            {
                //If the effect is invisibility and was created by Blizzard, remove it
                RemoveEffect(oEntering, eAOE);
            }
        }
        //Get next effect on the target
        eAOE = GetNextEffect(oEntering);
    }
    RemoveSpellEffects(SPELL_INVISIBILITY_SPHERE, oCaster, oEntering);
}

//Remove Invisibility Sphere from party and friends
void RemovePartyInvisibility(object oCaster)
{
    object oElf = GetNearestObjectByTag("Elf");
    object oPC = GetFirstPC();
    object oPlayer = GetFirstFactionMember(oPC, FALSE);

    while (GetIsObjectValid(oPlayer))
    {
        RemoveInvisibilitySphere(oPlayer, oCaster);
        oPlayer = GetNextFactionMember(oPC, FALSE);
    }

    if(GetIsObjectValid(oElf))
    {
        RemoveInvisibilitySphere(oElf, oCaster);
    }
}

void main()
{
    object oEntering = GetEnteringObject();

    if(GetIsPC(oEntering))
    {
        if(PlotLevelGet("Blizzard") == 11)
        {
            PlotLevelSet("Blizzard", 12);
        }

        if(PlotLevelGet("Elf") == 16)
        {
             PlotLevelSet("Elf", 17);
        }
    }
    else
    //Set Blizzard to Plot when she enters this trigger to
    //prevent her being slain by tower archers
    if(GetTag(oEntering) == "Blizzard")
    {
        if(PlotLevelGet("KTGateDestroyed") == 0)
        {
            SetPlotFlag(oEntering, TRUE);
        }
        //Remove Blizzard's invisibility sphere to aid PC in seeing her
        RemoveInvisibilitySphere(oEntering, oEntering);
        RemovePartyInvisibility(oEntering);
    }
}
