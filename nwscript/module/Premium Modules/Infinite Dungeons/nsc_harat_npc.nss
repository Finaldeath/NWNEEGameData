//::///////////////////////////////////////////////
//:: nsc_harat_npc
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    OnSpellCastAt event script

    This is for the Harat boss fight cutscene.
    Makes a couple creatures die when they get
    fireball cast at them.

    The fireball itself might kill them, but this
    will make sure.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 14, 2006
//:://////////////////////////////////////////////

void ApplyDeath();

void main()
{
    int nSpell = GetLastSpell();
    // one npc gets magic missile cast at them, this stuff doesn't apply
    // in that case
    if(nSpell == SPELL_FIREBALL)
    {
        // make sure I'm killable
        SetPlotFlag(OBJECT_SELF, FALSE);
        SetImmortal(OBJECT_SELF, FALSE);
        DelayCommand(0.3, ApplyDeath());
    }
}

void ApplyDeath()
{
    // only apply the death effect if the fireball spell didn't already kill me
    if(GetCurrentHitPoints() > 0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(FALSE, FALSE), OBJECT_SELF);
    }
}
