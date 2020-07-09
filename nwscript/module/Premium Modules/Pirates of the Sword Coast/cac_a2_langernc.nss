//::///////////////////////////////////////////////
//:: cac_a2_langernc
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Add Longneck Langer to the Skull and Bones
    Roster and increment the Poster Counter.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    int iRoster = GetLocalInt(oModule, "POTSC_CREW_ROASTER") + 1;
    int iPlot = GetLocalInt(GetModule(), "A2_LANGER");
    string sNormal = "";
    string sDead = "";

    if (iPlot == 70)
    {   //XPM - Langer
        sNormal = "a3_langer2";
        sDead = "a3_langer2_dead";
    }
    else
    {   //Normal - Langer
        sNormal = "a3_langer1";
        sDead = "a3_langer1_dead";
    }

    SetLocalString(oModule, "NPC_CREW" + IntToString(iRoster), sNormal);
    SetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iRoster), sDead);
    SetLocalInt(oModule, "POTSC_CREW_ROASTER", (iRoster));
    SetLocalInt(oModule, "POTSC_CREW_LANGER", TRUE);
}
