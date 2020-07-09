// create the maids and guards if a fire wasn't lit in the basement

#include "hf_in_spawn"

void RemoveCreatures(string sTag, object oArea)
{
    int i = 1;
    object o = GetObjectByTag(sTag, i);
    while (GetIsObjectValid(o))
    {
        if (GetObjectType(o) == OBJECT_TYPE_CREATURE)
        {
            if (!GetIsDead(o) && GetArea(o) == oArea)
            {
                DestroyObject(o);
            }
        }
        o = GetObjectByTag(sTag, ++i);
    }
}

void SpawnNPCs(object oPC)
{
    // create maids
    SpawnEnter(oPC);

    // create guards unless they are all down fighting the fire
    // ... or feldran is already dead (they must have run away)
    if (GetLocalInt(GetModule(), "nFeldranFire") == 0 &&
        GetLocalInt(GetModule(), "nFandocFeldranSpawned") == 0)
    {
        int i = 0;
        object oWP = GetObjectByTag("WP_AR2002_KNIGHT", i);
        while (GetIsObjectValid(oWP))
        {
            object oGuard = CreateObject(OBJECT_TYPE_CREATURE, "ks_exeltis_knigh", GetLocation(oWP));
            oWP = GetObjectByTag("WP_AR2002_KNIGHT", ++i);
        }

        i = 0;
        oWP = GetObjectByTag("WP_AR2002_GUARD", i);
        while (GetIsObjectValid(oWP))
        {
            object oGuard = CreateObject(OBJECT_TYPE_CREATURE, "ks_exeltis_guard", GetLocation(oWP));
            oWP = GetObjectByTag("WP_AR2002_GUARD", ++i);
        }
    }
}

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nEntered") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nEntered", 1);
            SpawnNPCs(oPC);
        }

        // if feldran is dead, his guards flee
        if (GetLocalInt(GetModule(), "nFandocFeldranDead") != 0)
        {
            RemoveCreatures("ks_exeltis_guard", OBJECT_SELF);
            RemoveCreatures("ks_exeltis_knight", OBJECT_SELF);
        }
    }
}
