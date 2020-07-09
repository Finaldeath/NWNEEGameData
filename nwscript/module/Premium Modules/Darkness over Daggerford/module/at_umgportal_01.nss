// this portal teleports the player to/from umgatlik's prison

#include "hf_in_npc"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    if (GetLocalInt(OBJECT_SELF, "nExit"))
    {
        // if Umgatlik is dead, Gumbril can go home
        object oUmgatlik = GetNearestObjectByTag("ks_umgatlik", oPC);
        if (!GetIsObjectValid(oUmgatlik) || GetIsDead(oUmgatlik))
        {
            // the player has killed umgatlik, so the altar is useless
            object oAltar = GetObjectByTag("pl_umgatliks_altar");
            SetLocalInt(oAltar, "nUmgatlikDead", 1);
            PlotLevelSet("ks_jared", 6);

            // Gumbril will follow the player home if he is still here
            object oGumbril = GetNearestObjectByTag("ks_gumbril", oPC);
            if (GetIsObjectValid(oGumbril) && !GetIsDead(oGumbril) &&
                !GetIsEnemy(oGumbril, oPC))
            {
                PlotLevelSet(GetTag(oGumbril), 3);
                object oWP = GetWaypointByTag("WP_AR2104_PORTAL_ENTER");
                AssignCommand(oGumbril, ClearAllActions());
                AssignCommand(oGumbril, ActionJumpToObject(oWP));
            }
        }

        // travel from AR2105 (prison) into AR2104 (shrine)
        TeleportToWaypoint(oPC, "WP_AR2104_PORTAL_ENTER", TRUE);
    }
    else
    {
        // travel from AR2104 (shrine) into AR2105 (prison)
        TeleportToWaypoint(oPC, "WP_AR2105_PORTAL_ENTER", TRUE);
    }
}
