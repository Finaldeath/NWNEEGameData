//::///////////////////////////////////////////////
//:: inc_govmanor.nss
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Include file for a couple functions that
    are used in multiple scripts in the
    Spindrift: Governor's Manor area.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: April 21, 2005
//:://////////////////////////////////////////////
#include "_inc_experience"
#include "inc_global"

// Langer leaves prison, goes to Monkey's Cutlass - done in more than one
// script, hence why I put it into a function
// oPC - The PC we use for the journal entry and XP stuff
void LangerLeavesPrison(object oPC, object oArea);

// Tattooist leaves prison, goes to tattoo parlour - done in more than one
// script, hence why I put it into a function
// oPC - The PC we use for the journal entry and XP stuff
void TattooistLeavesPrison(object oPC, object oArea);

//------------------------------------------------------------------------------

// Langer leaves prison, goes to Monkey's Cutlass - done in more than one
// script, hence why I put it into a function
// oPC - The PC we use for the journal entry and XP stuff
void LangerLeavesPrison(object oPC, object oArea)
{
    object oModule = GetModule();
    object oLanger = GetObjectByTagInArea("a2_langer2", oArea);

    int iEXP = GetJournalQuestExperience("a2_langer");
    iEXP = ConvertPercent(iEXP, 1.00f);

    AssignCommand(oModule, ExecuteScript("exe_a2_crewinc", oPC));

    SetLocalInt(oLanger, "EXIT_TO_CUTLESS", TRUE);
    HandoutQuestXP(oPC, iEXP);

    SetLocalInt(oModule, "A2_LANGER", 70);
    AddJournalQuestEntry("a2_langer", 70, oPC);

    if(!IsInConversation(oLanger)) ExecuteScript("cex_langer_exit", oLanger);
}

// Tattooist leaves prison, goes to tattoo parlour - done in more than one
// script, hence why I put it into a function
// oPC - The PC we use for the journal entry and XP stuff
void TattooistLeavesPrison(object oPC, object oArea)
{
    object oModule = GetModule();
    object oTattooist = GetObjectByTagInArea("a2_tattooist", oArea);

    int iDoOnce = GetLocalInt(oModule, "cac_a2_tttst30");
    int iEXP = GetJournalQuestExperience("a2_tttst");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oModule, "cac_a2_tttst30", TRUE);
        SetLocalInt(oTattooist, "EXIT_TO_PARLOR", TRUE);

        // give the player the IOU
        CreateItemOnObject("a2_ioutatt", oPC);

        iEXP = ConvertPercent(iEXP, 1.00f);
        HandoutQuestXP(oPC, iEXP);
        SetLocalInt(oModule, "A2_TTTST", 30);
        AddJournalQuestEntry("a2_tttst", 30, oPC);

        // the shop is open for business
        ExecuteScript("exe_a2_tattoo20", oPC);

        if(!IsInConversation(oTattooist)) ExecuteScript("cex_tattoo_exit", oTattooist);
    }
}
