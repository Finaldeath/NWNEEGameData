// onEnter event for area 0807 (boonmoppet's hole)
// .. apply falling damage, and run a cutscene

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // apply falling damage to players who enter
        if (GetLocalInt(oPC, "nAR0800_JumpedHole") == 1)
        {
            object oFallMaster = GetObjectByTag("bw_ar0807_fall");
            SignalEvent(oFallMaster, EventUserDefined(501));
        }

        // apply teleport visual effect to players who enter
        if (GetLocalInt(oPC, "nIH_Ported") == 1)
        {
            DeleteLocalInt(oPC, "nIH_Ported");
            effect eVFX = EffectVisualEffect(VFX_IMP_UNSUMMON);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPC);
        }

        // run the cutscene where boonmoppet talks to the player
        // .. (if the player didn't kill the girl already)
        if (GetLocalInt(OBJECT_SELF, "nCut1Played") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nCut1Played", 1);
            object oGirl = GetObjectByTag("ac_boonmoppet");
            if (GetIsObjectValid(oGirl) && !GetIsDead(oGirl))
            {
                DelayCommand(1.0, CutscenePlay(oPC, "mv_ar0807_1"));
            }
        }
    }
    else
    {
        // boonmoppet's pets are frozen at first so they don't attack during cutscene
        if (GetTag(oPC) == "c_kocrachn")
        {
            if (GetLocalInt(OBJECT_SELF, "nUnfreeze") == 0)
            {
                effect eFreeze = EffectCutsceneImmobilize();
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFreeze, oPC);
            }
        }
    }
}
