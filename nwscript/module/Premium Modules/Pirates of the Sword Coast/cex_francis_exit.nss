//::///////////////////////////////////////////////
//:: cex_francis_exit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Sir Francis goes to the Monkey's Cutless
    after joining the PC's crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oFrancis = OBJECT_SELF;
    object oDoor = GetObjectByTag("");
    object oWPCutless = GetWaypointByTag("WP_FRANCIS_HOME");

    location lCutless = GetLocation(oWPCutless);
    int iExit = GetLocalInt(oFrancis, "EXIT_TO_CUTLESS");
    effect eGhost = EffectCutsceneGhost();

    if (iExit == TRUE)
    {
        SetLocalInt(oFrancis, "EXIT_TO_CUTLESS", FALSE);
        SetLocalInt(oFrancis, "NO_TALKIE", TRUE);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oFrancis, 10.0f);
        ChangeToStandardFaction(oFrancis, STANDARD_FACTION_DEFENDER);
        SetPlotFlag(oFrancis, TRUE);

        AssignCommand(oFrancis, ClearAllActions(TRUE));
        DelayCommand(0.1f, AssignCommand(oFrancis, ActionMoveToObject(oDoor, TRUE)));
        DelayCommand(0.2f, AssignCommand(oFrancis, ActionDoCommand(SetLocalInt(oFrancis, "NO_TALKIE", FALSE))));
        DelayCommand(0.3f, AssignCommand(oFrancis, ActionJumpToLocation(lCutless)));

    }
    else
    {
        ExecuteScript("nw_walk_wp", oFrancis);
    }
}
