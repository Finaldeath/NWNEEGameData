#include "hf_in_cutscene"
#include "hf_in_spawn"
#include "hf_in_plot"

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

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        SetLocalInt(GetModule(), "iDisableOilBarrels", 1);
        //Spawn Soliana
        if(GetLocalInt(OBJECT_SELF, "iAreaSpawn") == 0)
        {
            SetLocalInt(OBJECT_SELF, "iAreaSpawn", 1);
            SpawnEnter(oPC);
        }

        // feldran confronts the player the first time entered
        if (GetLocalInt(OBJECT_SELF, "nPlayed") == 0 &&
            GetLocalInt(GetModule(), "nFandocFeldranDead") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nPlayed", 1);
            CutscenePlay(oPC, "mv_ar2003_1");
        }

        // griswald is with the princess after feldran is dead
        if (GetLocalInt(OBJECT_SELF, "nPlayed2") == 0)
        {
            if (GetLocalInt(GetModule(), "nFandocFeldranDead") == 1)
            {
                SetLocalInt(OBJECT_SELF, "nPlayed2", 1);
                object oWP = GetWaypointByTag("WP_AR2003_GRISWALD");
                CreateObject(OBJECT_TYPE_CREATURE, "ks_griswald", GetLocation(oWP));
                PlotLevelSet("ks_griswald", 5);
                PlotLevelSet("ks_soliana", 2);
            }
        }

        // if feldran is dead, his guards flee
        if (GetLocalInt(GetModule(), "nFandocFeldranDead") != 0)
        {
            RemoveCreatures("ks_exeltis_guard", OBJECT_SELF);
            RemoveCreatures("ks_exeltis_knight", OBJECT_SELF);
        }
    }
}
