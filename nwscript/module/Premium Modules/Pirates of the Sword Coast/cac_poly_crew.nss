//:://////////////////////////////////////////////
//:: cac_poly_crew
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set the custom token for the current amount
    of Crew Members Recruited.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    int iCrewCount = GetLocalInt(oModule, "A2_CREWCOUNT");

    // 8 Possable Crew Members.
    SetCustomToken(1502, IntToString(iCrewCount));
}
