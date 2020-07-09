//::///////////////////////////////////////////////
//:: cex_a3_kolmarr
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Move Kolmarr to the top of the hill.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Jan 2005
//:://////////////////////////////////////////////

void main()
{
    object oKolmarr = OBJECT_SELF;
    object oWPJump = GetWaypointByTag("WP_JUMKOLMARR");

    effect eSmokePuff1 = EffectVisualEffect(VFX_DUR_GLOBE_MINOR);
    effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);

    location lKolMarr = GetLocation(oKolmarr);

    int iPlot = GetLocalInt(GetModule(), "A3_DEAD");
    int iDoOnce = GetLocalInt(oKolmarr, "cex_a3_kolmarr");

    if ((iDoOnce == FALSE) && (iPlot >= 20))
    {
        SetLocalInt(oKolmarr, "cex_a3_kolmarr", TRUE);
        SetLocalInt(oKolmarr, "NO_TALKIE", TRUE);

        AssignCommand(oKolmarr, PlayAnimation(ANIMATION_LOOPING_CONJURE1));
        DelayCommand(0.5f, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,
            eSmokePuff1, lKolMarr, 3.0f));
        DelayCommand(1.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
            eSummon, lKolMarr));

        DelayCommand(1.25f, JumpToLocation(GetLocation(oWPJump)));
        DelayCommand(2.0f, SetLocalInt(oKolmarr, "NO_TALKIE", FALSE));
    }
}
