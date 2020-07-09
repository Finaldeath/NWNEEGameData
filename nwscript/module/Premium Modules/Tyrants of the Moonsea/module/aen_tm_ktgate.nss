//Area OnEnter for Kur-Tharsu Main Gate
//Play cutscene, and spawn Blizzard, Elf, and The Wrecker if appropriate

#include "hf_in_cutscene"
#include "hf_in_friend"
#include "hf_in_plot"

const string PLOT_HENCH_DIALOG = "plot_hen_dlg_all";

void main()
{
    object oDirector = GetObjectByTag("KTDirector");
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC)&& GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        if (PlotLevelGet(PLOT_HENCH_DIALOG) < 13)
            PlotLevelSet(PLOT_HENCH_DIALOG, 13);

        SetLocalInt(OBJECT_SELF, "nEntered", 1);
        SetObjectVisualTransform(GetObjectByTag("KTCatapult"),
                                 OBJECT_VISUAL_TRANSFORM_SCALE, 2.0);
        CutscenePlay(oPC, "cut_tm_ktgate");
    }

    //Spawn Blizzard if appropriate
    if(GetIsPC(oPC) && PlotLevelGet("Blizzard") == 10 &&
       GetLocalInt(OBJECT_SELF, "nBlizzardSpawned") == 0)
    {
        object oBlizzard =
            CreateObject(OBJECT_TYPE_CREATURE, "blizzard",
                         GetLocation(GetWaypointByTag("WP_THKTMG_BLIZZARD")));

        SetLocalObject(oDirector, "oBlizzard", oBlizzard);
        SetLocalString(oBlizzard, "sHome", "WP_THKTMG_BLIZZARD");
        SetLocalInt(OBJECT_SELF, "nBlizzardSpawned", 1);
        FriendSetMaster(oPC, oBlizzard);
    }

    //Spawn The Wrecker if appropriate
    if(GetIsPC(oPC) && PlotLevelGet("TheWrecker") == 1 &&
       GetLocalInt(OBJECT_SELF, "nWreckerSpawned") == 0)
    {
        object oWrecker =
            CreateObject(OBJECT_TYPE_CREATURE, "thewrecker",
                         GetLocation(GetWaypointByTag("WP_THKTMG_WRECKER")));

        SetLocalObject(oDirector, "oWrecker", oWrecker);
        SetLocalInt(OBJECT_SELF, "nWreckerSpawned", 1);
    }

    //Spawn Elf if appropriate
    if(GetIsPC(oPC) && PlotLevelGet("Elf") == 15 &&
       GetLocalInt(OBJECT_SELF, "nElfSpawned") == 0)
    {
        object oElf =
            CreateObject(OBJECT_TYPE_CREATURE, "elf",
                         GetLocation(GetWaypointByTag("WP_THKTMG_ELF")));

        SetLocalObject(oDirector, "oElf", oElf);
        SetLocalString(oElf, "sHome", "WP_THKTMG_ELF");
        SetLocalInt(OBJECT_SELF, "nElfSpawned", 1);
        FriendSetMaster(oPC, oElf);
    }
}
