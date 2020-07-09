// PC is meeting Burnas at well. Teleport Burnas to well and set variable
// .. also handle some odd pathfinding bugs in the TNO tileset

void main()
{
    object oPC = GetEnteringObject();

    // this code is duplicated from the area heartbeat event
    // .. without it the jonas boys would sometimes walk west
    // .. to go east (path finding bug in TNO?)
    if (GetTag(oPC) == "ac_jonas1")
    {
        SetLocalInt(oPC, "no_banter", 1);
        SetLocalInt(oPC, "no_hb", 1);
        AssignCommand(oPC,ClearAllActions());
        AssignCommand(oPC,ActionMoveToObject(GetObjectByTag("wp_jonas1_outside")));
        AssignCommand(oPC,ActionDoCommand(SetLocalInt(oPC, "no_banter", 0)));
        AssignCommand(oPC,ActionDoCommand(SetLocalInt(oPC, "no_hb", 0)));
    }
    if (GetTag(oPC) == "ac_jonas2")
    {
        SetLocalInt(oPC, "no_hb", 1);
        SetLocalInt(oPC, "no_banter", 1);
        AssignCommand(oPC,ClearAllActions());
        AssignCommand(oPC,ActionMoveToObject(GetObjectByTag("wp_jonas2_outside")));
        AssignCommand(oPC,ActionDoCommand(SetLocalInt(oPC, "no_banter", 0)));
        AssignCommand(oPC,ActionDoCommand(SetLocalInt(oPC, "no_hb", 0)));
    }
    // ... end of TNO work-around code

    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF,"fired") == 1) return;

        if (GetLocalInt(oPC, "ac_burnas_bard") == 3)
        {
            object oWP = GetObjectByTag("wp_ac_burnas");
            object oTarget = GetObjectByTag("ac_burnas");
            SetLocalInt(oPC, "ac_burnas_bard", 4);
            AssignCommand(oTarget, ClearAllActions());
            AssignCommand(oTarget, ActionJumpToObject(oWP));
            SetLocalInt(OBJECT_SELF,"fired",1);
        }
    }
}
