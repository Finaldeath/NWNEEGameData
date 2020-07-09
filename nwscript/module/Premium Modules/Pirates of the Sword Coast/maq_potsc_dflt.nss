//::///////////////////////////////////////////////
//:: maq_potsc_default
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    On Item Aquire script.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: October, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    object oItem = GetModuleItemAcquired();
    object oPC = GetModuleItemAcquiredBy();
    object oLoser = GetModuleItemAcquiredFrom();

    string sItemName = GetName(oItem);
    string sTag = GetTag(oItem);

    int iStack = GetModuleItemAcquiredStackSize();
    int iDoOnce, iCounter, iPlot;

    location lStart = GetStartingLocation();

    // (K2-4/18/2005)Brutal Hammerfix to prevent plot items
    // from firing Journal entries when aquired on load or
    // when entering the module with an Exported character
    if (((GetAreaFromLocation(lStart)) == (GetArea(oPC)))
      || (GetArea(oPC) == OBJECT_INVALID))
    {
        return ;
    }

    if (GetIsPC(oPC) == TRUE)
    {
        //:://////////////////////////////////////////////
        // Rahman's Cargo Plot in Act 0
        //:://////////////////////////////////////////////
        if (sTag == "a0_rahmansbook")
        {
            ExecuteScript("exe_a0_cargo80", oPC);
        }

        //:://////////////////////////////////////////////
        // Porcelaing Cup Plot in Act 0
        //:://////////////////////////////////////////////
        if (sTag == "a0rm_cup")
        {
            ExecuteScript("exe_a0_seige35", oPC);
        }

        //:://////////////////////////////////////////////
        // Sweet Maries Flower Plot from act 2
        //:://////////////////////////////////////////////
        if (GetTag(oItem) == "a2_flowers")
        {
            ExecuteScript("exe_a2_sweet40", oPC);
        }

        //:://////////////////////////////////////////////
        // Sweet Maries Flower Plot from act 2
        //:://////////////////////////////////////////////
        if (GetTag(oItem) == "a2_nwscepter")
        {
            ExecuteScript("exe_a2_scepter20", oPC);
        }

        //:://////////////////////////////////////////////
        // Willigan's belongings in act 2
        //:://////////////////////////////////////////////
        if (GetTag(oItem) == "a2_wwboots")
        {
            ExecuteScript("exe_a2_wwboot20", oPC);
        }
        if (GetTag(oItem) == "a2_wwgarb")
        {
            ExecuteScript("exe_a2_wwgarb20", oPC);
        }
        if (GetTag(oItem) == "a2_wwcutless")
        {
            ExecuteScript("exe_a2_wwctls20", oPC);
        }

        //:://////////////////////////////////////////////
        // The sacred wood and R.A.F.T. plans handlers
        //:://////////////////////////////////////////////
        if (GetTag(oItem) == "a1_sacredwood")
        {
            // Check if the player already aquired the plans.
            iPlot = GetLocalInt(GetModule(), "A1_ESCP");
            if (iPlot == 30)
            {
                ExecuteScript("exe_a1_escp40", oModule);
            }
            else
            {
                ExecuteScript("exe_a1_escp20", oModule);
            }
        }
        else if (GetTag(oItem) == "a1_raftplans")
        {
            // update the Dwarf plot.
            ExecuteScript("exe_a1_dwarf80", oPC);

            // Check if the player already aquired the wood.
            iPlot = GetLocalInt(GetModule(), "A1_ESCP");
            if (iPlot == 20)
            {
                ExecuteScript("exe_a1_escp40", oModule);
            }
            else
            {
                ExecuteScript("exe_a1_escp30", oModule);
            }
        }

        //:://////////////////////////////////////////////
        // Survival Items counter for Poly's Dialog
        //:://////////////////////////////////////////////
        iCounter = GetLocalInt(oModule, "SURVIVAL_COUNTER");
        if (GetTag(oItem) == "a1_stick_long")
        {
            iDoOnce = GetLocalInt(oModule, "SURVIVAL_STICKLONG");
            if (iDoOnce == FALSE)
            {
                SetLocalInt(oModule, "SURVIVAL_STICKLONG", TRUE);
                SetLocalInt(oModule, "SURVIVAL_COUNTER", (iCounter + 1));
            }
        }
        else if (GetTag(oItem) == "a1_stick")
        {
            iDoOnce = GetLocalInt(oModule, "SURVIVAL_STICK");
            if (iDoOnce == FALSE)
            {
                SetLocalInt(oModule, "SURVIVAL_STICK", TRUE);
                SetLocalInt(oModule, "SURVIVAL_COUNTER", (iCounter + 1));
            }
        }
        else if (GetTag(oItem) == "a1_tinder")
        {
            iDoOnce = GetLocalInt(oModule, "SURVIVAL_TINDER");
            if (iDoOnce == FALSE)
            {
                SetLocalInt(oModule, "SURVIVAL_TINDER", TRUE);
                SetLocalInt(oModule, "SURVIVAL_COUNTER", (iCounter + 1));
            }
        }
        else if (GetTag(oItem) == "a1_stone")
        {
            iDoOnce = GetLocalInt(oModule, "SURVIVAL_STONE");
            if (iDoOnce == FALSE)
            {
                SetLocalInt(oModule, "SURVIVAL_STONE", TRUE);
                SetLocalInt(oModule, "SURVIVAL_COUNTER", (iCounter + 1));
            }
        }
        else if (GetTag(oItem) == "a1_flint")
        {
            iDoOnce = GetLocalInt(oModule, "SURVIVAL_FLINT");
            if (iDoOnce == FALSE)
            {
                SetLocalInt(oModule, "SURVIVAL_FLINT", TRUE);
                SetLocalInt(oModule, "SURVIVAL_COUNTER", (iCounter + 1));
            }
        }
        else if (GetTag(oItem) == "a1_leather")
        {
            iDoOnce = GetLocalInt(oModule, "SURVIVAL_LEATHER");
            if (iDoOnce == FALSE)
            {
                SetLocalInt(oModule, "SURVIVAL_LEATHER", TRUE);
                SetLocalInt(oModule, "SURVIVAL_COUNTER", (iCounter + 1));
            }
        }
        else if (GetTag(oItem) == "a1_catgut")
        {
            iDoOnce = GetLocalInt(oModule, "SURVIVAL_CATGUT");
            if (iDoOnce == FALSE)
            {
                SetLocalInt(oModule, "SURVIVAL_CATGUT", TRUE);
                SetLocalInt(oModule, "SURVIVAL_COUNTER", (iCounter + 1));
            }
        }
        else if (GetTag(oItem) == "a1_rawmeat")
        {
            iDoOnce = GetLocalInt(oModule, "SURVIVAL_RAWMEAT");
            if (iDoOnce == FALSE)
            {
                SetLocalInt(oModule, "SURVIVAL_RAWMEAT", TRUE);
                SetLocalInt(oModule, "SURVIVAL_COUNTER", (iCounter + 1));
            }
        }
        else if (GetTag(oItem) == "a1_feather")
        {
            iDoOnce = GetLocalInt(oModule, "SURVIVAL_FEATHER");
            if (iDoOnce == FALSE)
            {
                SetLocalInt(oModule, "SURVIVAL_FEATHER", TRUE);
                SetLocalInt(oModule, "SURVIVAL_COUNTER", (iCounter + 1));
            }
        }
        else if (GetTag(oItem) == "a1_ichor")
        {
            iDoOnce = GetLocalInt(oModule, "SURVIVAL_ICHOR");
            if (iDoOnce == FALSE)
            {
                SetLocalInt(oModule, "SURVIVAL_ICHOR", TRUE);
                SetLocalInt(oModule, "SURVIVAL_COUNTER", (iCounter + 1));
            }
        }
    }
}
