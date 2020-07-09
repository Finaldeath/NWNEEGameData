//::///////////////////////////////////////////////
//:: cac_a2_fillcrew
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Automated Roster filling script for the
    Skull and Bones crew.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    int iRoster = 0;
    int iPlot = 0;

    iPlot = GetLocalInt(oModule, "A2_REDTIP");
    if (iPlot >= 40)
    {
        iRoster++;
        SetLocalString(oModule, "NPC_CREW" + IntToString(iRoster), "a3_redtip");
        SetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iRoster), "a3_redtip_dead");
        SetLocalInt(oModule, "POTSC_CREW_REDTIP", TRUE);
    }

    iPlot = GetLocalInt(oModule, "A2_SHAKEY");
    if (iPlot >= 30)
    {
        iRoster++;
        SetLocalString(oModule, "NPC_CREW" + IntToString(iRoster), "a3_shakey");
        SetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iRoster), "a3_shakey_dead");
        SetLocalInt(oModule, "POTSC_CREW_SHAKEY", TRUE);
    }

    iPlot = GetLocalInt(oModule, "A2_SWEET");
    if (iPlot >= 50)
    {
        iRoster++;
        SetLocalString(oModule, "NPC_CREW" + IntToString(iRoster), "a3_sweet");
        SetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iRoster), "a3_sweet_dead");
        SetLocalInt(oModule, "POTSC_CREW_SWEET", TRUE);
    }

    iPlot = GetLocalInt(oModule, "A2_VANTAB");
    if(iPlot >= 40)
    {
        iRoster++;
        SetLocalString(oModule, "NPC_CREW" + IntToString(iRoster), "a3_vantab");
        SetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iRoster), "a3_vantab_dead");
        SetLocalInt(oModule, "POTSC_CREW_VANTAB", TRUE);
    }

    iPlot = GetLocalInt(oModule, "A2_WHIPD");
    if(iPlot >= 50)
    {
        iRoster++;
        SetLocalString(oModule, "NPC_CREW" + IntToString(iRoster), "a3_willigan");
        SetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iRoster), "a3_willigan_dead");
        SetLocalInt(oModule, "POTSC_CREW_WILLIGAN", TRUE);
    }

    iPlot = GetLocalInt(oModule, "A2_BLACKR");
    if(iPlot >= 30)
    {
        iRoster++;
        SetLocalString(oModule, "NPC_CREW" + IntToString(iRoster), "a3_honey");
        SetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iRoster), "a3_honey_dead");
        SetLocalInt(oModule, "POTSC_CREW_BLACKR", TRUE);
    }

    iPlot = GetLocalInt(oModule, "A2_BLOODS");
    if(iPlot >= 30)
    {
        iRoster++;
        SetLocalString(oModule, "NPC_CREW" + IntToString(iRoster), "a3_vengaul");
        SetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iRoster), "a3_vengaul_dead");
        SetLocalInt(oModule, "POTSC_CREW_BLOODS", TRUE);
    }

    iPlot = GetLocalInt(oModule, "A2_FRANC");
    if (iPlot >= 80)
    {
        iRoster++;
        SetLocalString(oModule, "NPC_CREW" + IntToString(iRoster), "a3_francis");
        SetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iRoster), "a3_francis_dead");
        SetLocalInt(oModule, "POTSC_CREW_FRANCIS", TRUE);
    }

    iPlot = GetLocalInt(oModule, "A2_LANGER");
    if (iPlot == 60)
    {
        iRoster++;
        SetLocalString(oModule, "NPC_CREW" + IntToString(iRoster), "a3_langer1");
        SetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iRoster), "a3_langer1_dead");
        SetLocalInt(oModule, "POTSC_CREW_LANGER", TRUE);
    }
    else if (iPlot == 70)
    {
        iRoster++;
        SetLocalString(oModule, "NPC_CREW" + IntToString(iRoster), "a3_langer2");
        SetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iRoster), "a3_langer2_dead");
        SetLocalInt(oModule, "POTSC_CREW_LANGER", TRUE);
    }

    iPlot = GetLocalInt(oModule, "A2_PEGLEG");
    if(iPlot >= 40)
    {
        iRoster++;
        SetLocalString(oModule, "NPC_CREW" + IntToString(iRoster), "a3_pegleg");
        SetLocalString(oModule, "NPC_CREW_DEAD" + IntToString(iRoster), "a3_pegleg_dead");
        SetLocalInt(oModule, "POTSC_CREW_PEGLEG", TRUE);
    }

}
