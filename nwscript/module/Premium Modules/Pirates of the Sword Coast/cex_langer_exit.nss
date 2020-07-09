//::///////////////////////////////////////////////
//:: cex_langer_exit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Long Neck Langer goes to the Monkey's
    Cutless after joining the PC's crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oLanger = OBJECT_SELF;
    object oDoor = GetObjectByTag("");
    object oWPCutless = GetWaypointByTag("WP_LANGER_HOME");

    effect eGhost = EffectCutsceneGhost();
    location lCutless = GetLocation(oWPCutless);
    int iExit = GetLocalInt(oLanger, "EXIT_TO_CUTLESS");

    if (iExit == TRUE)
    {
        SetLocalInt(oLanger, "EXIT_TO_CUTLESS", FALSE);
        SetLocalInt(oLanger, "NO_TALKIE", TRUE);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oLanger, 10.0f);
        ChangeToStandardFaction(oLanger, STANDARD_FACTION_DEFENDER);
        SetPlotFlag(oLanger, TRUE);

        AssignCommand(oLanger, ClearAllActions(TRUE));
        DelayCommand(0.1f, AssignCommand(oLanger, ActionMoveToObject(oDoor, TRUE)));
        DelayCommand(0.2f, AssignCommand(oLanger,
            ActionDoCommand(SetLocalInt(oLanger, "NO_TALKIE", FALSE))));
        DelayCommand(0.3f, AssignCommand(oLanger, ActionJumpToLocation(lCutless)));

    }
}
