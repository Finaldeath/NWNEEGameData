// area heartbeat for AR0700 (West Farms)
// .. move both jonas's around day or night

void main()
{
    object oJ1 = GetObjectByTag("ac_jonas1");
    object oJ2 = GetObjectByTag("ac_jonas2");

    if (GetLocalInt(GetModule(), "ac_werewolf") >=1)     return;
    if (IsInConversation(oJ1))                   return;
    if (GetLocalInt(oJ1, "no_banter")== 1)       return;
    if (IsInConversation(oJ2))                   return;
    if (GetLocalInt(oJ2, "no_banter")== 1)       return;
    if (GetLocalInt(GetModule(),"no_700_hb")==1) return;

    // move inside at night
    if (GetIsNight() || GetIsDusk())
    {
        if (GetLocalString(GetModule(),"ac_time")== "night") return;
        SetLocalString(GetModule(),"ac_time","night");

        SetLocalInt(oJ1, "no_banter", 1);
        AssignCommand(oJ1,ClearAllActions());
        AssignCommand(oJ1,ActionMoveToObject(GetObjectByTag("wp_jonas1_inside")));
        AssignCommand(oJ1,ActionDoCommand(SetLocalInt(oJ1, "no_banter", 0)));

        SetLocalInt(oJ2, "no_banter", 1);
        AssignCommand(oJ2,ClearAllActions());
        AssignCommand(oJ2,ActionMoveToObject(GetObjectByTag("wp_jonas2_inside")));
        AssignCommand(oJ2,ActionDoCommand(SetLocalInt(oJ2, "no_banter", 0)));
    }

    // move outside during day
    // .. note that some of this code is duplicated in the area's onEnter event
    // .. due to some odd TNO pathfinding bugs
    if (GetIsDay() || GetIsDawn())
    {
        if (GetLocalString(GetModule(),"ac_time")== "day") return;
        SetLocalString(GetModule(),"ac_time","day");

        SetLocalInt(oJ1, "no_banter", 1);
        SetLocalInt(oJ1, "no_hb", 1);
        AssignCommand(oJ1,ClearAllActions());
        AssignCommand(oJ1,ActionMoveToObject(GetObjectByTag("wp_jonas1_outside")));
        AssignCommand(oJ1,ActionDoCommand(SetLocalInt(oJ1, "no_banter", 0)));
        AssignCommand(oJ1,ActionDoCommand(SetLocalInt(oJ1, "no_hb", 0)));

        SetLocalInt(oJ2, "no_hb", 1);
        SetLocalInt(oJ2, "no_banter", 1);
        AssignCommand(oJ2,ClearAllActions());
        AssignCommand(oJ2,ActionMoveToObject(GetObjectByTag("wp_jonas2_outside")));
        AssignCommand(oJ2,ActionDoCommand(SetLocalInt(oJ2, "no_banter", 0)));
        AssignCommand(oJ2,ActionDoCommand(SetLocalInt(oJ2, "no_hb", 0)));
    }
}
