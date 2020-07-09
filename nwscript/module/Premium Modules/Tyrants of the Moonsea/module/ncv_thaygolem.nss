//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: ncv_tm_thaygolem
//::////////////////////////////////////////////////////
//:: Quest: Thayan Ambassador
//:: OnConversation Script for Golems, makes them move
//:: towards the waypoint again, if it's in the same
//:: area.
//::////////////////////////////////////////////////////

const string WP_TAG_EXIT_ALL = "WP_cut_thayanam0_move_all";

void main()
{
    object oWaypoint = GetNearestObjectByTag(WP_TAG_EXIT_ALL, OBJECT_SELF);

    if (GetIsObjectValid(oWaypoint))
    {
        ActionForceMoveToObject(oWaypoint, FALSE);
    }
    else
    {
        ExecuteScript("x2_def_onconv", OBJECT_SELF);
    }
}
