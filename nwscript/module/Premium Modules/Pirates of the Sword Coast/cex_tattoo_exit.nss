//::///////////////////////////////////////////////
//:: cex_tattoo_exit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Tattooist makes his way back to his parlor
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
void main()
{
    object oTattooist = OBJECT_SELF;
    object oDoor = GetObjectByTag("a2_office_spindrift");
    // JE: No longer jumps to parlour - he's placed there, we just need to
    // destroy this dude.
    //object oWPParlor = GetWaypointByTag("WP_TATTOO_PARLOR");

    //location lParlor = GetLocation(oWPParlor);
    int iExit = GetLocalInt(oTattooist, "EXIT_TO_PARLOR");
    effect eGhost = EffectCutsceneGhost();

    if (iExit == TRUE)
    {
        SetLocalInt(oTattooist, "EXIT_TO_PARLOR", FALSE);
        SetLocalInt(oTattooist, "NO_TALKIE", TRUE);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGhost, oTattooist, 10.0f);
        ChangeToStandardFaction(oTattooist, STANDARD_FACTION_DEFENDER);
        SetPlotFlag(oTattooist, TRUE);

        AssignCommand(oTattooist, ClearAllActions(TRUE));
        DelayCommand(0.1f, AssignCommand(oTattooist,
            ActionMoveToLocation(GetLocation(oDoor), TRUE)));
        DelayCommand(0.2f, AssignCommand(oTattooist, DestroyObject(OBJECT_SELF)));

        DestroyObject(OBJECT_SELF, 30.0); // failsafe, just in case the action queue somehow gets messed up
        //AssignCommand(oTattooist, ActionJumpToLocation(lParlor));
        //AssignCommand(oTattooist, ActionDoCommand(SetLocalInt(oTattooist, "NO_TALKIE", FALSE)));
    }
}
