// the player has destroyed abatorru's sphere in AR1110
// .. this releases the mage Edalseye who attacks Abatorru

#include "hf_in_plot"
#include "hf_in_graphics"
#include "nw_i0_generic"

void main()
{
    // mage is released and attacks the devil
    object oMage = GetNearestObjectByTag("ks_edalseye", OBJECT_SELF);
    if (GetIsObjectValid(oMage) && !GetIsDead(oMage))
    {
        // the geas is lifted from edalseye
        PlotLevelSet("ks_edalseye", 2);
        string sQuote = GetLocalString(GetModule(), "QUOTE");
        AssignCommand(oMage, SpeakString(sQuote+"Free! The geas is broken! I am free!"+sQuote, TALKVOLUME_SHOUT));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DISPEL), oMage);

        // make edalseye friendly towards the player so that he doesn't toast the player with spells
        ChangeToStandardFaction(oMage, STANDARD_FACTION_DEFENDER);
        SetIsTemporaryFriend(oMage, GetFirstPC(), FALSE);

        // edalseye attacks the devil
        object oDevil = GetNearestObjectByTag("ks_abatorru", OBJECT_SELF);
        if (GetIsObjectValid(oDevil))
        {
            // make edalseye ultra buff so that he can survive a fight with the devil
            float fDur = 360.0;
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACIncrease(10), oMage, fDur);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageReduction(100, DAMAGE_POWER_PLUS_TEN), oMage, fDur);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_ALL, 10), oMage, fDur);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectTemporaryHitpoints(100), oMage, fDur);
            AssignCommand(oMage, DetermineCombatRound());
        }
    }

    // fancy vfx when the sphere explodes
    location lLoc = GetLocation(OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), OBJECT_SELF);
    int i;
    for (i=1; i<=15; i++)
    {
        DrawCircle(lLoc, i*0.20, VFX_IMP_WILL_SAVING_THROW_USE);
    }

    // give the player a journal
    object oPC = GetFirstPC();
    AddJournalQuestEntry("j83", 11, oPC);
}
