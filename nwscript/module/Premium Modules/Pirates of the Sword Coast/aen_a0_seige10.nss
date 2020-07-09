//::///////////////////////////////////////////////
//:: aen_a0_seige10
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Captain hasn't been on deck for hours.
    This isn't like him, it would be a good
    idea to find out what's holding him up.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_global"
#include "_inc_experience"

void RecurEquip (object oPC, object oItem, int iSlot)
{
    if (GetItemInSlot(iSlot, oPC) != oItem)
    {
        //SendMessageToPC(oPC, "Forcing '" + GetTag(oItem) + "' into a slot.");
        AssignCommand(oPC, ActionEquipItem(oItem, iSlot));
        DelayCommand(1.0f, RecurEquip(oPC, oItem, iSlot));
    }
}

void main()
{
    object oModule = GetModule();
    object oPC = GetEnteringObject();
    int iEXP = GetJournalQuestExperience("a0_seige");
    int iDoOnceA = GetLocalInt(oPC, "aen_a0_seige10_EQP");
    int iDoOnceB = GetLocalInt(oModule, "aen_a0_seige10");

    if ((GetIsPCNotDM(oPC) == TRUE) )
    {
        if (iDoOnceA == FALSE)
        {
            SetLocalInt(oPC, "aen_a0_seige10_EQP", TRUE);

            //Force them to wear their uniform.
            object oUniform = GetItemPossessedBy(oPC, "a0_sailorsuniform");
            if (GetIsObjectValid(oUniform) == FALSE)
            {
                oUniform = CreateItemOnObject("a0_sailorsuniform", oPC);
            }

            object oEquipped = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
            if (oEquipped != oUniform)
            {
                AssignCommand(oPC, ClearAllActions());
                RecurEquip(oPC, oUniform, INVENTORY_SLOT_CHEST);
            }
        }

        if (iDoOnceB == FALSE)
        {
            SetLocalInt(oModule, "aen_a0_seige10", TRUE);

            //HandoutQuestXP(oPC, iEXP);
            SetLocalInt(oModule, "A0_SEIGE", 10);
            AddJournalQuestEntry("a0_seige", 10, oPC);

            //JE: Moved this to the end-cutscene script
            //DoSinglePlayerAutoSave();

            cs_PreCutsceneFade(CS_FADE_TYPE_BLACK);
            cs_StartCutscene("cut_a0_atsea", "cut_a0_atsea_end", 2.0, TRUE);
        }
    }
}
