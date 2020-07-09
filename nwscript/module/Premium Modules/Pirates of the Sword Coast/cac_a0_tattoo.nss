//::///////////////////////////////////////////////
//:: Act 0: Create Tattoo
//:: cac_a0_tattoo.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Check to see what tattoos Nisar and the PC
     have requested and then create them.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 18, 2005
//:://////////////////////////////////////////////
#include "_inc_experience"

const string sTattoo = "Rusty Al casts Create Magic Tattoo.";
const string sPermanency = "Rusty Al casts Permanency.";

void RecurEquip (object oPC, object oItem, int iSlot);

void main()
{
    object oPC = GetPCSpeaker();
    object oNisar0 = GetObjectByTag("a0_hench_nisar");
    object oNisar2 = GetObjectByTag("a2_hench_nisar");
    object oHide = GetItemPossessedBy(oPC, "potsc_pc_hide");
    object oHideN0 = GetItemPossessedBy(oNisar0, "potsc_pc_hide");
    object oHideN2 = GetItemPossessedBy(oNisar2, "potsc_pc_hide");
    itemproperty ipTattoo;
    itemproperty ipTattooN;
    int iPlotState = 0;
    string sPC_ID = GetName(oPC)+GetPCPlayerName(oPC);
    string sPC_Tattoo = GetLocalString(oPC, "s_a0_pc_tattoo");
    string sNisar_Tattoo = GetLocalString(GetModule(), "s_a0_nis_tattoo");
    int bNisar_Tattoo = GetLocalInt(GetModule(), "bNisarTattoo_Act0");
    effect eEffect = GetFirstEffect(oPC);

    //Remove all polymorph effects.
    while (GetIsEffectValid(eEffect))
    {
        if (GetEffectType(eEffect) == EFFECT_TYPE_POLYMORPH)
        {
            RemoveEffect(oPC, eEffect);
        }

        //Update the loop variable
        eEffect = GetNextEffect(oPC);
    }

    //Take 100 gp from the player.
    TakeGoldFromCreature(100, oPC);

    //If the player's hide is invalid, create one and equip it.
//    if (GetIsObjectValid(oHide) == FALSE)
//    {
//        oHide = CreateItemOnObject("potsc_pc_hide", oPC);
//        RecurEquip(oPC, oHide, INVENTORY_SLOT_CARMOUR);
//    }

    //Determine the appropriate item property.
    //Determine the appropriate plot and journal state.
    if (sPC_Tattoo == "a0_tattoo_anchor")
    {
        ipTattoo = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL, 2);
        iPlotState = 20;
    }
    else if (sPC_Tattoo == "a0_tattoo_heart")
    {
        ipTattoo = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE, 2);
        iPlotState = 30;
    }
    else if (sPC_Tattoo == "a0_tattoo_eye")
    {
        ipTattoo = ItemPropertyACBonus(1);
        iPlotState = 40;
    }
    else if (sPC_Tattoo == "a0_tattoo_gnaked")
    {
        ipTattoo = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX, 2);
        iPlotState = 50;
    }

    //Send the feedback messages
    SendMessageToPC(oPC, sTattoo);
    SendMessageToPC(oPC, sPermanency);

    //Apply the effects of the PC's chosen tattoo to their hide item
    AddItemProperty(DURATION_TYPE_PERMANENT, ipTattoo, oHide);

    //Assign the plot & journal state.
    SetLocalInt(GetModule(), "A0_TATTOO", iPlotState);
    AddJournalQuestEntry("a0_tattoo", iPlotState, oPC);

    //Assign the experience
    int iEXP = GetJournalQuestExperience("a0_tattoo");
    //HandoutQuestXP(oPC, iEXP);

    //Flag the PC as having received their tattoo for Act 0
    SetLocalInt(GetModule(), "bTattoo_Act0_"+sPC_ID, TRUE);

    //Verify that Nisar has not already received his tattoo for Act 0
    if (bNisar_Tattoo == FALSE)
    {
        //Verify that Nisar has actually selected a tattoo
        if (sNisar_Tattoo != "")
        {
            //If Act 0 Nisar's hide is invalid, create one and equip it.
            if (GetIsObjectValid(oHideN0) == FALSE)
            {
                oHideN0 = CreateItemOnObject("potsc_pc_hide", oNisar0);
                RecurEquip(oNisar0, oHideN0, INVENTORY_SLOT_CARMOUR);
            }

            //If Act 2 Nisar's hide is invalid, create one and equip it.
            if (GetIsObjectValid(oHideN2) == FALSE)
            {
                oHideN2 = CreateItemOnObject("potsc_pc_hide", oNisar2);
                RecurEquip(oNisar2, oHideN2, INVENTORY_SLOT_CARMOUR);
            }

            //Determine the appropriate item property for Nisar's tattoo.
            if (sNisar_Tattoo == "a0_tattoo_anchor")
            {
                ipTattooN = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL, 2);
            }
            else if (sNisar_Tattoo == "a0_tattoo_heart")
            {
                ipTattooN = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE, 2);
            }
            else if (sNisar_Tattoo == "a0_tattoo_eye")
            {
                ipTattooN = ItemPropertyACBonus(1);
            }
            else if (sNisar_Tattoo == "a0_tattoo_gnaked")
            {
                ipTattooN = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX, 2);
            }

            //Apply the effects of Nisar's chosen tattoo to his hide items in both acts.
            AddItemProperty(DURATION_TYPE_PERMANENT, ipTattooN, oHideN0);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipTattooN, oHideN2);

            //Flag Nisar as having received his tattoo for Act 0
            SetLocalInt(GetModule(), "bNisarTattoo_Act0", TRUE);

            //Clear Nisar's selected tattoo variable to avoid future confusion
            SetLocalString(GetModule(), "s_a0_nis_tattoo", "");
        }
    }
}

void RecurEquip (object oPC, object oItem, int iSlot)
{
    if (GetItemInSlot(iSlot, oPC) != oItem)
    {
        //SendMessageToPC(oPC, "Forcing '" + GetTag(oItem) + "' into a slot.");
        AssignCommand(oPC, ActionEquipItem(oItem, iSlot));
        DelayCommand(1.0f, RecurEquip(oPC, oItem, iSlot));
    }
}
