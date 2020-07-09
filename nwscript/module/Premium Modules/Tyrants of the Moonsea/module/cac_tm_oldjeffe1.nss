//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_oldjeffe1
//:: DATE: December 30, 2018
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Old Jeffers leaves for his default Waypoint
//::////////////////////////////////////////////////////

const string NPC_RESREF_JEFFERS = "oldjeffers";
const string NPC_TAG_JEFFERS = "OldJeffers";
const string WP_TAG_JEFFERS_FINAL = "WP_cut_sylar_jeff_final";

const string WP_TAG_LEAVE = "WP_cut_sylar_leave";

void main()
{
    object oJeffers = OBJECT_SELF;
    object oNewJeffers = OBJECT_INVALID;
    object oFinalWaypoint = GetWaypointByTag(WP_TAG_JEFFERS_FINAL);
    int nHfArgValue = GetLocalInt(oJeffers, "HF_ARG");

    if (GetDistanceBetween(oJeffers, oFinalWaypoint) > 15.0f)
    {
        // Set up new Jeffers
        oNewJeffers = CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_JEFFERS, GetLocation(oFinalWaypoint), FALSE, NPC_TAG_JEFFERS);
        SetLocalInt(oNewJeffers, "HF_ARG", nHfArgValue);
        // Make Old Jeffers leave
        SetLocalString(oJeffers, "HF_EXIT_NAME", WP_TAG_LEAVE);
        ExecuteScript("hf_cs_exit", oJeffers);
    }
    else if (GetDistanceBetween(oJeffers, oFinalWaypoint) > 2.0f)
    {
        AssignCommand(oJeffers, ClearAllActions(TRUE));
        AssignCommand(oJeffers, ActionMoveToObject(oFinalWaypoint, FALSE, 0.5f));
        AssignCommand(oJeffers, ActionDoCommand(SetFacing(GetFacing(oFinalWaypoint))));
    }
}
