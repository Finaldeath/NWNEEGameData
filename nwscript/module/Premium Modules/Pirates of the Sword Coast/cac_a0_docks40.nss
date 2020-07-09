//::///////////////////////////////////////////////
//:: cac_a0_docks40
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Rose has set sail!
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "x0_i0_henchman"
#include "_inc_experience"
#include "inc_polymorphfix"
#include "_inc_generic"

void main()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();
    object oAllendry = OBJECT_SELF;
    object oNisar1 = GetObjectByTag("a0_hench_nisar");;
    object oNisar2 = GetObjectByTag("a2_hench_nisar");
    object oWaypoint = GetWaypointByTag("intro_ship_way_1");
    int iEXP = GetJournalQuestExperience("a0_docks");
    int iPlotCheck = 0;

    //HandoutQuestXP(oPC, iEXP);
    SetLocalInt(GetModule(), "A0_DOCKS", 40);
    AddJournalQuestEntry("a0_docks", 40, oPC);

    // lockdown unused plots.
    iPlotCheck = GetLocalInt(oModule, "A0_TATTOO");
    if ((iPlotCheck > 0) && (iPlotCheck < 20))
    {
        SetLocalInt(oModule, "A0_TATTOO", 50);
        AddJournalQuestEntry("a0_tattoo", 50, oPC);
    }

    iPlotCheck = GetLocalInt(oModule, "A0_AMBUSH");
    if ((iPlotCheck == 10) || (iPlotCheck == 30))
    {
        SetLocalInt(oModule, "A0_AMBUSH", 50);
        AddJournalQuestEntry("a0_ambush", 50, oPC);
    }

    iPlotCheck = GetLocalInt(oModule, "A0_TURFWR");
    if ((iPlotCheck > 0) || (iPlotCheck < 100))
    {
        SetLocalInt(oModule, "A0_TURFWR", 120);
        AddJournalQuestEntry("a0_turfwr", 120, oPC);
    }

    //destroy Nisar
    FireHenchman(GetMaster(oNisar1), oNisar1);
    AssignCommand(oNisar1, ClearAllActions(TRUE));
    AssignCommand(oNisar1, SetIsDestroyable(TRUE, FALSE, FALSE));

    //Transfer Nisars levelup rules
    //SetLocalInt(oNisar2, "X0_L_LEVELRULES",
    //    GetLocalInt(oNisar1, "X0_L_LEVELRULES"));

    DestroyObject(oNisar1, 1.0f);

    // Teleport the players to the ship
    oPC = GetFirstPC();
    while(GetIsObjectValid(oPC) == TRUE)
    {
        if(GetIsPCNotDM(oPC))
        {
            RemovePolymorph(oPC);
            ForceRest(oPC);
            // JumpToObject is not reliable
            //AssignCommand(oPC, JumpToObject(oWaypoint));
            JumpPCsToLocation(GetLocation(oWaypoint), 0, oPC);
        }
        oPC = GetNextPC();
    }

}
