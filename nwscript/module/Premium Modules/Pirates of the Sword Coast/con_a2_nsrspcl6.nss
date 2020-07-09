//::///////////////////////////////////////////////
//:: con_a2_nsrspcl6
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The player has obtained their tattoo for
    Act 2. Crew is NOT yet full. Tasina has
    NOT yet fled.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oSelf = OBJECT_SELF;
    object oModule = GetModule();

    string sPC_ID = GetName(oPC)+GetPCPlayerName(oPC);

    int iPlotR = GetLocalInt(oModule, "A2_MIDROSE");
    int iPlotC = GetLocalInt(GetModule(), "A2_CREW");
    int bTattoo = GetLocalInt(oModule, "bTattoo_Act2_" + sPC_ID);
    int iResult = FALSE;

    if((iPlotR < 40) && (iPlotC < 60) && (bTattoo == TRUE))
    {
        return TRUE;
    }

    return iResult;
}
