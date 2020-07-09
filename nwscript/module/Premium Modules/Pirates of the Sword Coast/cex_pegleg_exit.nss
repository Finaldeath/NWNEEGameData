//::///////////////////////////////////////////////
//:: cex_pegleg_exit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Pegleg goes to the corner of the Monkey's
    Cutless after joining the PC's crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oPegLeg = OBJECT_SELF;
    object oDoor = GetObjectByTag("WP_PEGLEG_HOME");
    object oWPCutless = GetWaypointByTag("WP_PEGLEG_HOME");

    location lCutless = GetLocation(oWPCutless);
    int iExit = GetLocalInt(oPegLeg, "EXIT_TO_CUTLESS");
    effect eGhost = EffectCutsceneGhost();

    if (iExit == TRUE)
    {
        SetLocalInt(oPegLeg, "EXIT_TO_CUTLESS", FALSE);
        SetLocalInt(oPegLeg, "NO_TALKIE", TRUE);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oPegLeg, 10.0f);
        ChangeToStandardFaction(oPegLeg, STANDARD_FACTION_DEFENDER);
        SetPlotFlag(oPegLeg, TRUE);

        AssignCommand(oPegLeg, ClearAllActions(TRUE));
        DelayCommand(0.1f, AssignCommand(oPegLeg, ActionMoveToObject(oDoor, TRUE)));
        DelayCommand(0.2f, AssignCommand(oPegLeg, ActionDoCommand(
            SetLocalInt(oPegLeg, "NO_TALKIE", FALSE))));
        DelayCommand(0.3f, AssignCommand(oPegLeg, ActionJumpToLocation(lCutless)));

    }
}
