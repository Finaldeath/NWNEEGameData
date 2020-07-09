// teleport the player using a placeable "use" event
// .. set HF_DESTINATION to the tag of the destination object
// .. set HF_FADE to -1 if you DO NOT want a fade-to-black
// .. set HF_VFX to 1 if you want a magical VFX on the player

#include "hf_in_npc"

// applies the given vfx to the entire party
void ApplyVfxToParty(object oPC, int nVfx, float fDelay)
{
    effect eVfx = EffectVisualEffect(nVfx);

    // all party members
    object oParty = GetFirstFactionMember(oPC, TRUE);
    while (GetIsObjectValid(oParty) && GetArea(oParty) == GetArea(oPC))
    {
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVfx, oParty));
        oParty = GetNextFactionMember(oPC, TRUE);
    }

    // all non-party members such as familiars
    oParty = GetFirstFactionMember(oPC, FALSE);
    while (GetIsObjectValid(oParty) && GetArea(oParty) == GetArea(oPC))
    {
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVfx, oParty));
        oParty = GetNextFactionMember(oPC, FALSE);
    }
}

void main()
{
    object oPC = GetLastUsedBy();

    // locate the destination object
    string sDestTag = GetLocalString(OBJECT_SELF, "HF_DESTINATION");
    if (sDestTag == "")
    {
        sDestTag = GetTag(OBJECT_SELF) + "_DST";
    }
    object oDest = GetObjectByTag(sDestTag);

    // optionally apply the VFX_IMP_AC_BONUS to the party
    int nVfx = GetLocalInt(OBJECT_SELF, "HF_VFX");
    if (nVfx > 0)
    {
        ApplyVfxToParty(oPC, VFX_IMP_AC_BONUS, 0.0);
    }

    // teleport the player
    int nFade = GetLocalInt(OBJECT_SELF, "HF_FADE");
    if (nFade >= 0)
    {
        TeleportToObject(oPC, oDest, TRUE);
    }
    else
    {
        TeleportToObject(oPC, oDest, FALSE);
    }
}
