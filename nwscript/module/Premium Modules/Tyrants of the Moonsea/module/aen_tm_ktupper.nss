//Area OnEnter for Kur-Tharsu Upper Floor - destroy Director object from
//Kur-Tharsu Main Gate and populate Director object for this floor

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        object oDirector = GetObjectByTag("KTUFDirector");
        SetLocalObject(oDirector, "oOgre1", GetNearestObjectByTag("KTOgreMage1", oDirector));
        SetLocalObject(oDirector, "oOgre2", GetNearestObjectByTag("KTOgreMage2", oDirector));
        SetLocalObject(oDirector, "oOgre3", GetNearestObjectByTag("KTOgreMage3", oDirector));
        SetLocalObject(oDirector, "oOgre4", GetNearestObjectByTag("KTOgreMage4", oDirector));
        SetLocalObject(oDirector, "oMaganus", GetNearestObjectByTag("StrongholdMaganus", oDirector));

        DestroyObject(GetObjectByTag("KTDirector"));

        //Create Shadovar assassins if their assistance has previously been promised
        if(PlotLevelGet("Thalia") == 4 &&
           GetLocalInt(OBJECT_SELF, "nShadovarAssassinsSpawned") == 0)
        {
            object oAssassin;

            oAssassin = CreateObject(OBJECT_TYPE_CREATURE, "shadovarassasskt",
                             GetLocation(GetWaypointByTag("WP_THKTUF_SPAWN_KT_ASSASSIN1")),
                             FALSE);
            SetLocalString(oAssassin, "sHome", "WP_THKTUF_SPAWN_KT_ASSASSIN1");
            SetLocalFloat(oAssassin, "FOLLOW_DISTANCE", 6.0);

            oAssassin = CreateObject(OBJECT_TYPE_CREATURE, "shadovarassasskt",
                                     GetLocation(GetWaypointByTag("WP_THKTUF_SPAWN_KT_ASSASSIN2")),
                                     FALSE);
            SetLocalString(oAssassin, "sHome", "WP_THKTUF_SPAWN_KT_ASSASSIN2");
            SetLocalFloat(oAssassin, "FOLLOW_DISTANCE", 7.0);

            oAssassin = CreateObject(OBJECT_TYPE_CREATURE, "shadovarassasskt",
                                     GetLocation(GetWaypointByTag("WP_THKTUF_SPAWN_KT_ASSASSIN3")),
                                     FALSE);
            SetLocalString(oAssassin, "sHome", "WP_THKTUF_SPAWN_KT_ASSASSIN3");
            SetLocalFloat(oAssassin, "FOLLOW_DISTANCE", 8.0);

            SetLocalInt(OBJECT_SELF, "nShadovarAssassinsSpawned", 1);
        }
        SetLocalInt(OBJECT_SELF, "nEntered", 1);
    }
}
