//::///////////////////////////////////////////////
//:: con_a2_crewskb
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC Gathered a crew and is ready to set
    sail on the Skull and Bones?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iPlotNecro = GetLocalInt(GetModule(), "A2_NECRO");
    int iPlotCrew = GetLocalInt(GetModule(), "A2_CREW");

    if ((iPlotNecro > 10) && (iPlotCrew > 50))
    {
        return TRUE;
    }

    return FALSE;
}
