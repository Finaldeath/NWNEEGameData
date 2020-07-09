//::///////////////////////////////////////////////
//:: cex_nvrwntr_exit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Your Neverwinter friend goes to the Monkey's
    Cutless after joining the PC's crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oFriend = OBJECT_SELF;
    object oDoor = GetObjectByTag("a2_sandyspit_spindrift");
    object oWPCutless = GetWaypointByTag("WP_NEVERW_HOME");

    location lCutless = GetLocation(oWPCutless);
    int iExit = GetLocalInt(oFriend, "EXIT_TO_CUTLESS");
    effect eGhost = EffectCutsceneGhost();

    if (iExit == TRUE)
    {
        SetLocalInt(oFriend, "EXIT_TO_CUTLESS", FALSE);
        SetLocalInt(oFriend, "NO_TALKIE", TRUE);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oFriend, 10.0f);
        ChangeToStandardFaction(oFriend, STANDARD_FACTION_DEFENDER);
        SetPlotFlag(oFriend, TRUE);

        AssignCommand(oFriend, ClearAllActions(TRUE));
        AssignCommand(oFriend, ActionMoveToObject(oDoor, TRUE));
        AssignCommand(oFriend, ActionJumpToLocation(lCutless));
        AssignCommand(oFriend, ActionDoCommand(SetLocalInt(oFriend, "NO_TALKIE", FALSE)));
    }
}
