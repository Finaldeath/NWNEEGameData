//::///////////////////////////////////////////////
//:: cac_a2_tttst30
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    You have released the Tattooist and he has
    offered you a favor in return.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
//:: Modified By: Jonathan Epp
//:: Modified On: April 21, 2005
//:: Moved functionality to a function, since I
//:: need to call it in the area on-exit script.
//:://////////////////////////////////////////////
#include "inc_govmanor"

void main()
{
    object oPC = GetPCSpeaker();
    TattooistLeavesPrison(oPC, GetArea(OBJECT_SELF));

/*
    object oModule = GetModule();
    object oTattooist = OBJECT_SELF;

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
    }
*/
}
