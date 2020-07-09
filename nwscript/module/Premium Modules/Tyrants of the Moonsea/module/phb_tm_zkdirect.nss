//Direct events in the Temple of the Black Lord finale

#include "hf_in_plot"

//Play casting animation and associated effect from Fzoul to Maganus
void PlayFzoulSpellEffect(object oTarget)
{
    int nDurType = DURATION_TYPE_INSTANT;
    int nRand = d8();
    int nSpell = 0;

    effect eVFX;

    switch(nRand)
    {
        case 1:
            nSpell = SPELL_BLINDNESS_AND_DEAFNESS;
            eVFX = EffectVisualEffect(VFX_FNF_BLINDDEAF);
        break;
        case 2:
            nSpell = SPELL_FLAME_ARROW;
            eVFX = EffectVisualEffect(VFX_FNF_FIRESTORM);
        break;
        case 3:
            nSpell = SPELL_HEAL;
            eVFX = EffectVisualEffect(VFX_IMP_HEALING_X);
            oTarget = OBJECT_SELF;
        break;
        case 4:
            nSpell = SPELL_NEGATIVE_ENERGY_RAY;
            eVFX = EffectVisualEffect(VFX_IMP_HARM);
        break;
        case 5:
            nSpell = SPELL_DESTRUCTION;
            eVFX = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
        break;
        case 6:
            nSpell = SPELL_DISPEL_MAGIC;
            eVFX = EffectVisualEffect(VFX_FNF_DISPEL);
        break;
        default:
            nSpell = 0;
        break;
    }

    if(nSpell > 0)
    {
        ActionCastFakeSpellAtObject(nSpell, oTarget);
        ActionDoCommand(ApplyEffectToObject(nDurType, eVFX, oTarget));
    }
    else
    {
        ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 3.0);
    }
}

//Play casting animation and associated effect from Maganus to Fzoul
void PlayMaganusSpellEffect(object oTarget)
{
    int nDurType = DURATION_TYPE_INSTANT;
    int nRand = d8();
    int nSpell = 0;

    effect eVFX;

    switch(nRand)
    {
        case 1:
            nSpell = SPELL_FIREBALL;
            eVFX = EffectVisualEffect(VFX_FNF_FIREBALL);
        break;
        case 2:
            nSpell = SPELL_LIGHTNING_BOLT;
            eVFX = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
        break;
        case 3:
            nSpell = SPELL_COLOR_SPRAY;
            eVFX = EffectVisualEffect(VFX_IMP_DEATH);
        break;
        case 4:
            nSpell = SPELL_FLAME_STRIKE;
            eVFX = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);
        break;
        case 5:
            nSpell = SPELL_GREATER_SPELL_BREACH;
            eVFX = EffectVisualEffect(VFX_IMP_BREACH);
        break;
        case 6:
            nSpell = SPELL_ICE_STORM;
            eVFX = EffectVisualEffect(VFX_FNF_ICESTORM);
        break;
        default:
            nSpell = 0;
        break;
    }

    if(nSpell > 0)
    {
        ActionCastFakeSpellAtObject(nSpell, oTarget);
        ActionDoCommand(ApplyEffectToObject(nDurType, eVFX, oTarget));
    }
    else
    {
        ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 3.0);
    }
}

int IsEvenRound()
{
    int nRound = GetLocalInt(OBJECT_SELF, "nRoundCounter");

    if((nRound % 2) == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

void main()
{
    int nPlot = PlotLevelGet(GetTag(OBJECT_SELF));
    int nRoundCounter = 0;

    object oFzoul = GetLocalObject(OBJECT_SELF, "oFzoul");
    object oMaganus = GetLocalObject(OBJECT_SELF, "oMaganus");
    object oPC = GetFirstPC();

    if(nPlot == 0)
    {
        return;
    }
    //Direct Fzoul and Maganus spell-battle in Temple of the Black Lord
    else if(nPlot == 1)
    {
        nRoundCounter = GetLocalInt(OBJECT_SELF, "nRoundCounter");
        SetLocalInt(OBJECT_SELF, "nRoundCounter", ++nRoundCounter);

        if(GetIsObjectValid(oFzoul) && !GetIsInCombat(oFzoul) &&
           !GetIsDead(oFzoul) && !IsInConversation(oFzoul))
        {
            if(IsEvenRound())
            {
                AssignCommand(oFzoul, PlayFzoulSpellEffect(oMaganus));
            }
        }

        if(GetIsObjectValid(oMaganus) && !GetIsInCombat(oMaganus) &&
           !GetIsDead(oMaganus) && !IsInConversation(oMaganus))
        {
            if(!IsEvenRound())
            {
                AssignCommand(oMaganus, PlayMaganusSpellEffect(oFzoul));
            }
        }
    }
    //PC rescued Maganus and arrived in Temple Grounds for final dialog
    else if(nPlot == 2)
    {
        if(PlotLevelGet("StrongholdMaganus") == 7)
        {
            if(GetIsObjectValid(oMaganus) && !GetIsInCombat(oMaganus) &&
              !GetIsDead(oMaganus) && !IsInConversation(oMaganus))
            {
                AssignCommand(oMaganus, ClearAllActions(TRUE));
                AssignCommand(oMaganus,
                    ActionStartConversation(oPC, "", FALSE, FALSE));
            }
        }
     }
}
