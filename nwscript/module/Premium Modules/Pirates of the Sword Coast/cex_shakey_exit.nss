//::///////////////////////////////////////////////
//:: cex_shakey_exit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Shakey McGuire goes to the Monkey's Cutless
    after joining the PC's crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oModule = GetModule();
    object oShakey = OBJECT_SELF;
    object oDoor = GetObjectByTag("a2_templetotown");
    object oWPCutless = GetWaypointByTag("WP_SHAKEY_HOME");

    location lCutless = GetLocation(oWPCutless);
    int iExit = GetLocalInt(oShakey, "EXIT_TO_CUTLESS");
    int iDestroy = GetLocalInt(oModule, "A2_SHAKEY");
    effect eGhost = EffectCutsceneGhost();

    if (iExit == TRUE)
    {
        SetLocalInt(oShakey, "EXIT_TO_CUTLESS", FALSE);
        SetLocalInt(oShakey, "NO_TALKIE", TRUE);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oShakey, 10.0f);
        ChangeToStandardFaction(oShakey, STANDARD_FACTION_DEFENDER);
        SetPlotFlag(oShakey, TRUE);

        AssignCommand(oShakey, ClearAllActions(TRUE));
        DelayCommand(0.1f, AssignCommand(oShakey, ActionMoveToObject(oDoor, TRUE)));

        if (iDestroy == 20)
        {
            DelayCommand(0.2f, AssignCommand(oShakey, ActionDoCommand(
                DestroyObject(oShakey))));
            DestroyObject(oShakey, 10.0f);
        }
        else
        {
            DelayCommand(0.2f, AssignCommand(oShakey, ActionDoCommand(SetLocalInt(oShakey, "NO_TALKIE", FALSE))));
            DelayCommand(0.3f, AssignCommand(oShakey, ActionJumpToLocation(lCutless)));
        }
    }
}
