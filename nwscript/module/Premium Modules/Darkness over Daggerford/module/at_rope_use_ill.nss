// the player uses a rope to descend into the forgotten shrine

#include "hf_in_npc"
#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    TeleportToWaypoint(oPC, "WP_AR2501B_ROPE_BOTTOM", TRUE);

    // create a roped placeable here (only if this is the first time)
    string sTag = GetTag(OBJECT_SELF);
    if (PlotLevelCheckEquals(sTag, 0))
    {
        PlotLevelSet(sTag, 1);

        // remove the player's rope
        object oRope = GetItemPossessedBy(oPC, "am_ropecoil");
        if (GetIsObjectValid(oRope))
        {
            DestroyObject(oRope);
        }

        // create the rope placeable
        location lSelf = GetLocation(OBJECT_SELF);
        CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_rope_drop", lSelf);
    }
}
