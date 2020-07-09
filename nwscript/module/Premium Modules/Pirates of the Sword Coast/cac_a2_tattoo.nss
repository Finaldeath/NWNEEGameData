//::///////////////////////////////////////////////
//:: Act 2: Create Tattoo
//:: cac_a2_tattoo.nss
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

const string sTattoo = "Falstaff casts Create Magic Tattoo.";
const string sPermanency = "Falstaff casts Permanency.";

void RecurEquip (object oPC, object oItem, int iSlot);

void main()
{
    object oPC = GetPCSpeaker();
    object oNisar = GetObjectByTag("a2_hench_nisar");
    object oHide = GetItemPossessedBy(oPC, "potsc_pc_hide");
    object oHideN = GetItemPossessedBy(oNisar, "potsc_pc_hide");
    itemproperty ipTattoo;
    itemproperty ipTattooN;
    int iPlotState = 0;
    string sPC_ID = GetName(oPC)+GetPCPlayerName(oPC);
    string sPC_Tattoo = GetLocalString(oPC, "s_a2_pc_tattoo");
    string sNisar_Tattoo = GetLocalString(GetModule(), "s_a2_nis_tattoo");
    int bNisar_Tattoo = GetLocalInt(GetModule(), "bNisarTattoo_Act2");
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

    //If the player's hide is invalid, create one and equip it.
//    if (GetIsObjectValid(oHide) == FALSE)
//    {
//        oHide = CreateItemOnObject("potsc_pc_hide", oPC);
//        RecurEquip(oPC, oHide, INVENTORY_SLOT_CARMOUR);
//    }

    //Determine the appropriate item property.
    //Determine the appropriate plot and journal state.
    if (sPC_Tattoo == "a2_tattoo_pirate")
    {
        ipTattoo = ItemPropertyBonusSpellResistance(12);
        iPlotState = 30;
    }
    else if (sPC_Tattoo == "a2_tattoo_flame")
    {
        ipTattoo = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 2);
        iPlotState = 40;
    }
    else if (sPC_Tattoo == "a2_tattoo_waves")
    {
        ipTattoo = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, 2);
        iPlotState = 50;
    }
    else if (sPC_Tattoo == "a2_tattoo_dragon")
    {
        ipTattoo = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, 2);
        iPlotState = 60;
    }

    //Send the feedback messages
    SendMessageToPC(oPC, sTattoo);
    SendMessageToPC(oPC, sPermanency);

    //Apply the effects of the PC's chosen tattoo to their hide item
    AddItemProperty(DURATION_TYPE_PERMANENT, ipTattoo, oHide);

    //Assign the plot & journal state.
    SetLocalInt(GetModule(), "A2_TATTOO", iPlotState);
    AddJournalQuestEntry("a2_tattoo", iPlotState, oPC);

    //Assign the experience
    int iEXP = GetJournalQuestExperience("a2_tattoo");
    iEXP = ConvertPercent(iEXP, 1.00f);
    HandoutQuestXP(oPC, iEXP);

    //Flag the PC as having received their tattoo for Act 2
    SetLocalInt(GetModule(), "bTattoo_Act2_"+sPC_ID, TRUE);

    //Verify that Nisar has not already received his tattoo for Act 2
    if (bNisar_Tattoo == FALSE)
    {
        //Verify that Nisar has actually selected a tattoo
        if (sNisar_Tattoo != "")
        {
            //If Act 2 Nisar's hide is invalid, create one and equip it.
            if (GetIsObjectValid(oHideN) == FALSE)
            {
                oHideN = CreateItemOnObject("potsc_pc_hide", oNisar);
                RecurEquip(oNisar, oHideN, INVENTORY_SLOT_CARMOUR);
            }

            //Determine the appropriate item property for Nisar's tattoo.
            if (sNisar_Tattoo == "a2_tattoo_pirate")
            {
                ipTattoo = ItemPropertyBonusSpellResistance(12);
            }
            else if (sNisar_Tattoo == "a2_tattoo_flame")
            {
                ipTattoo = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX, 2);
            }
            else if (sNisar_Tattoo == "a2_tattoo_waves")
            {
                ipTattoo = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS, 2);
            }
            else if (sNisar_Tattoo == "a2_tattoo_dragon")
            {
                ipTattoo = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR, 2);
            }

            //Apply the effects of Nisar's chosen tattoo to his hide item.
            AddItemProperty(DURATION_TYPE_PERMANENT, ipTattooN, oHideN);

            //Flag Nisar as having received his tattoo for Act 2
            SetLocalInt(GetModule(), "bNisarTattoo_Act2", TRUE);

            //Clear Nisar's selected tattoo variable to avoid future confusion
            SetLocalString(GetModule(), "s_a2_nis_tattoo", "");
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
