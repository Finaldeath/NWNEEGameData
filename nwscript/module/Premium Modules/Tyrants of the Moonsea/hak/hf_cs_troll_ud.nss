// userDefined event for trolls
// .. remembers how much acid/fire damage was done

#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

// regenerate any damage (except that caused by either fire or acid)
void Heartbeat()
{
    int nFireDmg = GetLocalInt(OBJECT_SELF, "nFireDmg");
    int nAcidDmg = GetLocalInt(OBJECT_SELF, "nAcidDmg");
    int nCurHP = GetCurrentHitPoints(OBJECT_SELF);
    int nMaxHP = GetMaxHitPoints(OBJECT_SELF) - nFireDmg - nAcidDmg;
    if (nCurHP < nMaxHP)
    {
        int nHeal = nMaxHP - nCurHP;
        if (nHeal > 5)
            nHeal = 5;
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nHeal), OBJECT_SELF);
    }
}

// remember how much fire and acid damage was done to this troll
void Damaged()
{
    int nF = GetDamageDealtByType(DAMAGE_TYPE_FIRE);
    if (nF > 0)
    {
        int nFireDmg = GetLocalInt(OBJECT_SELF, "nFireDmg");
        SetLocalInt(OBJECT_SELF, "nFireDmg", nFireDmg + nF);
    }
    int nA = GetDamageDealtByType(DAMAGE_TYPE_ACID);
    if (nA > 0)
    {
        int nAcidDmg = GetLocalInt(OBJECT_SELF, "nAcidDmg");
        SetLocalInt(OBJECT_SELF, "nAcidDmg", nAcidDmg + nA);
    }
}

void main()
{
    int nUser = GetUserDefinedEventNumber();

    if (nUser == EVENT_HEARTBEAT)
    {
        Heartbeat();
    }
    else if (nUser == EVENT_DAMAGED)
    {
        Damaged();
    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
        SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);
    }
}
