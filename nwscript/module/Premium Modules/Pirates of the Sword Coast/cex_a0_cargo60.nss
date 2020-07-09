//::///////////////////////////////////////////////
//:: cex_a0_cargo60
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Dockhands walk out at the end of the
    conversation.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 23, 2005
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    object oDockHand1 = GetObjectByTag("a0_dockhand1");
    object oDockHand2 = GetObjectByTag("a0_dockhand2");
    object oTarget = GetObjectByTag("WP_A0_SSTCMAPNOTE");
    effect eGhost = EffectCutsceneGhost();
    int iPlot = GetLocalInt(GetModule(), "A0_CARGO");

    if (iPlot == 60)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oDockHand1);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, oDockHand2);

        AssignCommand(oDockHand1, ActionMoveToObject(oTarget, TRUE));
        AssignCommand(oDockHand1, ActionDoCommand(DestroyObject(oDockHand1)));

        DelayCommand(0.5f, AssignCommand(oDockHand2, ActionMoveToObject(oTarget, TRUE)));
        DelayCommand(0.7f, AssignCommand(oDockHand2, ActionDoCommand(DestroyObject(oDockHand2))));

        //safety destruction after 5 seconds.
        AssignCommand(oModule, DelayCommand(5.0f, DestroyObject(oDockHand1)));
        AssignCommand(oModule, DelayCommand(5.0f, DestroyObject(oDockHand2)));
    }
}
