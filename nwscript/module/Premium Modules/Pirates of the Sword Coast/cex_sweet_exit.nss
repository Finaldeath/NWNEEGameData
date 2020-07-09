//::///////////////////////////////////////////////
//:: cex_sweet_exit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sweet Marie goes to the Monkey's Cutless
    after joining the PC's crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oMarie = OBJECT_SELF;
    object oDoor = GetObjectByTag("a2_templetotown");
    object oWPCutless = GetWaypointByTag("WP_SWEET_HOME");

    location lCutless = GetLocation(oWPCutless);
    int iExit = GetLocalInt(oMarie, "EXIT_TO_CUTLESS");
    effect eGhost = EffectCutsceneGhost();

    if (iExit == TRUE)
    {
        SetLocalInt(oMarie, "EXIT_TO_CUTLESS", FALSE);
        SetLocalInt(oMarie, "NO_TALKIE", TRUE);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oMarie, 10.0f);
        ChangeToStandardFaction(oMarie, STANDARD_FACTION_DEFENDER);
        SetPlotFlag(oMarie, TRUE);

        AssignCommand(oMarie, ClearAllActions(TRUE));
        DelayCommand(0.1f, AssignCommand(oMarie, ActionMoveToObject(oDoor, TRUE)));
        DelayCommand(0.2f, AssignCommand(oMarie, ActionDoCommand(
            SetLocalInt(oMarie, "NO_TALKIE", FALSE))));
        DelayCommand(0.3f, AssignCommand(oMarie, ActionJumpToLocation(lCutless)));

    }
}
