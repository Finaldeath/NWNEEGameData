// user defined event for xatuum
// .. summon undead skeletons when first attacked

#include "nw_i0_generic"
#include "hf_in_graphics"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

// summon a skeleton friend at a given location
void SummonFriend(location lLoc, int nType)
{
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD), lLoc);
    object oFriend = CreateObject(OBJECT_TYPE_CREATURE, "ks_bhaal_skel_1", lLoc);
    SetLocalInt(oFriend, "TYPE", nType);
}

// attacked event; summon friends when first attacked
void Attacked()
{
    if (GetLocalInt(OBJECT_SELF, "nSummonedFriends") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nSummonedFriends", 1);
        SetLocalInt(GetModule(), "xatuum_astriel", 1);
        // need to go hostile because my friends are in the hostile faction
        ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE);

        // fancy vfx
        location lLoc = GetLocation(OBJECT_SELF);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HARM), lLoc);
        DrawCircle(lLoc, 3.0, VFX_FNF_GAS_EXPLOSION_EVIL);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_PARALYZED), OBJECT_SELF);

        // summon friends
        int i = 1;
        object oFriend = GetNearestObjectByTag("ks_pl_bhaal_skel", OBJECT_SELF, i);
        while (GetIsObjectValid(oFriend))
        {
            int nType = GetLocalInt(oFriend, "TYPE");
            location lTargetLoc = GetLocation(oFriend);
            DelayCommand(0.25*i, SummonFriend(lTargetLoc, nType));
            DestroyObject(oFriend);
            oFriend = GetNearestObjectByTag("ks_pl_bhaal_skel", OBJECT_SELF, ++i);
        }
    }
}

void main()
{
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") != 0)
    {
        return;
    }

    int nUser = GetUserDefinedEventNumber();
    if (nUser == EVENT_ATTACKED)
    {
        Attacked();
    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);
    }
}

