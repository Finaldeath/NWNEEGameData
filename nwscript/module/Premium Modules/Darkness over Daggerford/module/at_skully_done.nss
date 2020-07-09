// this is the end of skully's quest. the player is returned outside of the tower

#include "hf_in_npc"
#include "hf_in_plot"
#include "hf_in_xp"

void main()
{
    object oPC = GetPCSpeaker();

    // move edalseye up to the first level of the tower
    object oEdalseye = GetNearestObjectByTag("ks_edalseye", oPC);
    if (GetIsObjectValid(oEdalseye))
    {
        DestroyObject(oEdalseye, 1.0);
        object oWP = GetWaypointByTag("WP_AR1105_EDALSEYE");
        CreateObject(OBJECT_TYPE_CREATURE, "ks_edalseye", GetLocation(oWP));
    }

    // wrap up the quest
    PlotLevelSet("ks_skully", 8);
    PlotLevelSet("ks_edalseye", 5);
    AddJournalQuestEntry("j83", 12, oPC);
    GiveQuestXPToCreature(oPC, "j83");
    SetLocalInt(GetModule(), "StrongholdQuest_mage", 0);

    // remove the portals that deldarine created
    // .. this means that the player won't be able to return to the tower
    object oPortal1 = GetObjectByTag("ks_pl_devportal2", 0);
    object oSound1  = GetNearestObjectByTag("snd_ar1100_portal", oPortal1);
    object oPortal2 = GetObjectByTag("ks_pl_devportal2", 1);
    object oSound2  = GetNearestObjectByTag("snd_ar1100_portal", oPortal2);
    DestroyObject(oPortal1);
    DestroyObject(oPortal2);
    SoundObjectStop(oSound1);
    SoundObjectStop(oSound2);

    // move the player outside
    AssignCommand(oPC, PlaySound("as_mg_telepout1"));
    TeleportToWaypoint(oPC, "WP_AR1100_TOWER_EXIT", TRUE);
}
