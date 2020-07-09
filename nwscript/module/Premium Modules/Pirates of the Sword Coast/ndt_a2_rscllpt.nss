//::///////////////////////////////////////////////
//:: Name ndt_a2_rscllpt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Rascally Pete is dead
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    object oPCPlayer = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    int iPlot = GetLocalInt(oModule, "cac_a2_franc50");

    if (iPlot < 50)
    {
        if (GetIsObjectValid(oPCPlayer) == FALSE)
        {
            oPCPlayer == GetFirstPC();
        }

        SetLocalInt(oModule, "A2_FRANC", 50);
        AddJournalQuestEntry("a2_franc", 50, oPCPlayer);
    }

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
