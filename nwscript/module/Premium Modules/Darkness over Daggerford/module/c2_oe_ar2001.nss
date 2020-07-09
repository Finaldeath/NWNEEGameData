#include "hf_in_cutscene"
#include "hf_in_spawn"

void RemoveCreatures(string sTag, object oArea)
{
    int i = 0;
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

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        SpawnEnter(oPC);

        // doors have to be closed for the cutscene trigger to work
        object oDoor;
        oDoor = GetObjectByTag("dt_ar2001_fire_door");
        AssignCommand(oDoor, ActionCloseDoor(oDoor));
        oDoor = GetObjectByTag("dt_ar2001_fire_door2");
        AssignCommand(oDoor, ActionCloseDoor(oDoor));

        // if feldran is ready to confront the player, his guards are gone
        object oMod = GetModule();
        if (GetLocalInt(oMod, "nFandocPrincessDead") == 1 &&
            GetLocalInt(oMod, "nFandocFeldranSpawned") == 0)
        {
            RemoveCreatures("ks_exeltis_guard", OBJECT_SELF);
            RemoveCreatures("ks_exeltis_knight", OBJECT_SELF);
        }

        // if feldran is dead, his guards flee
        if (GetLocalInt(oMod, "nFandocFeldranDead") != 0)
        {
            RemoveCreatures("ks_exeltis_guard", oPC);
            RemoveCreatures("ks_exeltis_knight", oPC);
        }
    }
}
