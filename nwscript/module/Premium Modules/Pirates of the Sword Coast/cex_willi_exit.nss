//::///////////////////////////////////////////////
//:: cex_willi_exit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Whipped Willigan goes to the Monkey's Cutless
    after joining the PC's crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oWilligan = OBJECT_SELF;
    object oDoor = GetObjectByTag("");
    object oWPCutless = GetWaypointByTag("WP_WILLIGAN_HOME");

    location lCutless = GetLocation(oWPCutless);
    int iExit = GetLocalInt(oWilligan, "EXIT_TO_CUTLESS");
    effect eGhost = EffectCutsceneGhost();

    if (iExit == TRUE)
    {
        SetLocalInt(oWilligan, "EXIT_TO_CUTLESS", FALSE);
        SetLocalInt(oWilligan, "NO_TALKIE", TRUE);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oWilligan, 10.0f);
        ChangeToStandardFaction(oWilligan, STANDARD_FACTION_DEFENDER);
        SetPlotFlag(oWilligan, TRUE);

        AssignCommand(oWilligan, ClearAllActions(TRUE));
        DelayCommand(0.1f, AssignCommand(oWilligan, ActionMoveToObject(oDoor, TRUE)));
        DelayCommand(0.2f, AssignCommand(oWilligan, ActionDoCommand(
            SetLocalInt(oWilligan, "NO_TALKIE", FALSE))));
        DelayCommand(0.3f, AssignCommand(oWilligan, ActionJumpToLocation(lCutless)));
    }
}
