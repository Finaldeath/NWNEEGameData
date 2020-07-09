void main()
{
    object oJonas = GetObjectByTag("ac_jonas1");
    object oJunior = GetObjectByTag("ac_jonas2");
    object oJonasTarget = GetWaypointByTag("wp_jonas_maze2");
    object oJuniorTarget = GetWaypointByTag("wp_junior_maze2");
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC))
    {
        if(GetLocalInt(OBJECT_SELF, "iEntered") == 0)
        {
            SetLocalInt(OBJECT_SELF, "iEntered", 1);
            SetLocalInt(GetModule(), "ac_werewolf", 4);
            SetLocalInt(oJunior, "iJuniorPursuing",0);
            AddJournalQuestEntry("j55", 6, oPC);
        }

        AssignCommand(oJonas, ClearAllActions(TRUE));
        AssignCommand(oJonas, ActionJumpToObject(oJonasTarget));
        AssignCommand(oJunior, ClearAllActions(TRUE));
        AssignCommand(oJunior, ActionJumpToObject(oJuniorTarget));
    }
}
