//::///////////////////////////////////////////////
//:: cex_redtip_exit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Red-Tip goes to the Monkey's Cutless after
    joining the PC's crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oRedTip = OBJECT_SELF;
    object oDoor = GetObjectByTag("a2_warehouse_spindrift");
    object oWPCutless = GetWaypointByTag("WP_REDTIP_HOME");

    location lCutless = GetLocation(oWPCutless);
    int iExit = GetLocalInt(oRedTip, "EXIT_TO_CUTLESS");
    effect eGhost = EffectCutsceneGhost();

    if (iExit == TRUE)
    {
        SetLocalInt(oRedTip, "EXIT_TO_CUTLESS", FALSE);
        SetLocalInt(oRedTip, "NO_TALKIE", TRUE);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oRedTip, 10.0f);
        ChangeToStandardFaction(oRedTip, STANDARD_FACTION_DEFENDER);
        SetPlotFlag(oRedTip, TRUE);

        AssignCommand(oRedTip, ClearAllActions(TRUE));
        DelayCommand(0.1f, AssignCommand(oRedTip, ActionMoveToObject(oDoor, TRUE)));
        DelayCommand(0.2f, AssignCommand(oRedTip, ActionDoCommand(
            SetLocalInt(oRedTip, "NO_TALKIE", FALSE))));
        DelayCommand(0.3f, AssignCommand(oRedTip, ActionJumpToLocation(lCutless)));
    }
}
