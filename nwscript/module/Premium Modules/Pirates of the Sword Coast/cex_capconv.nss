//::///////////////////////////////////////////////
//:: cex_capconv
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script moves the PC to the troglodyte
    cell after the cutscene where the PC is
    captured by the Stinking Trogs.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    location lWP = GetLocation(GetWaypointByTag("a1_trogcell"));
    effect eEffect = GetFirstEffect(oPC);

    while (GetIsEffectValid(eEffect) == TRUE)
    {
        DelayCommand(0.1f, RemoveEffect(oPC, eEffect));
        eEffect = GetNextEffect(oPC);
    }

    AssignCommand(oPC, JumpToLocation(lWP));
    SetCutsceneMode(oPC, FALSE);
    FadeFromBlack(oPC);
}
