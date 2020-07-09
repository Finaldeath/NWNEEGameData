//::///////////////////////////////////////////////
//:: inc_undead
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Handlers for the undead system
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void ApplyVFXEyes (object oPC);
void MakeUndead (object oPC);
void RemoveUndead (object oPC);
void RecurEquip (object oPC, object oItem, int iSlot);

// Apply the required visual effect.
void ApplyVFXEyes (object oPC)
{
    effect eVFXEyes, eVFXLight, eVFXFlies;
    int iGender = GetGender(oPC);
    int iRace = GetRacialType(oPC);
    int iMonkEyes = 0;

    switch (iRace)
    {
        case RACIAL_TYPE_HUMAN :
        case RACIAL_TYPE_HALFELF :
            if (iGender == GENDER_MALE)
                iMonkEyes = 518;
            else
                iMonkEyes = 519;
        break;
        case RACIAL_TYPE_DWARF :
            if (iGender == GENDER_MALE)
                iMonkEyes = 520;
            else
                iMonkEyes = 521;
        break;
        case RACIAL_TYPE_ELF :
            if (iGender == GENDER_MALE)
                iMonkEyes = 522;
            else
                iMonkEyes = 523;
        break;
        case RACIAL_TYPE_GNOME :
            if (iGender == GENDER_MALE)
                iMonkEyes = 524;
            else
                iMonkEyes = 525;
        break;
        case RACIAL_TYPE_HALFLING :
            if (iGender == GENDER_MALE)
                iMonkEyes = 526;
            else
                iMonkEyes = 527;
        break;
        case RACIAL_TYPE_HALFORC :
            if (iGender == GENDER_MALE)
                iMonkEyes = 528;
            else
                iMonkEyes = 529;
        break;
    }

    //eVFXLight = EffectVisualEffect(VFX_DUR_ANTI_LIGHT_10);
    //eVFXFlies = EffectVisualEffect(VFX_DUR_FLIES);

    // If we've found a valid pair of eyes, use them, else do the flies effect
    if (iMonkEyes != 0)
    {
        eVFXEyes = EffectVisualEffect(iMonkEyes);
    }
    else
    {
        eVFXEyes = EffectVisualEffect(VFX_DUR_FLIES);
    }

    // K2 - 2005_05_09
    // Set the VFX eyes to Supernatural so they aren't removed on rest.
    eVFXEyes = SupernaturalEffect(eVFXEyes);

    //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFXLight, oPC);
    //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFXFlies, oPC);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFXEyes, oPC);
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

void MakeUndead (object oPC)
{
    object oHide = GetItemPossessedBy(oPC, "potsc_pc_hide");
    string sRace;

    //Set up hit die variables
    int iHitDie = GetHitDice(oPC);
    int iOldMaxHP = GetMaxHitPoints(oPC);
    int iNewMaxHP = iHitDie;
    int iHitDieCounter = 0;
    effect eHitDie;

    //Create a regenerative property equal to 1/2 their hit die.
    int iRegen = iHitDie/2;
    itemproperty ipRegen = ItemPropertyRegeneration(iRegen);

    //Set up other item properties for the creature hide
    itemproperty ipWeapProfCre = ItemPropertyBonusFeat(FEAT_WEAPON_PROFICIENCY_CREATURE);
    itemproperty ipWeapProfSim = ItemPropertyBonusFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE);
    itemproperty ipDarkvision = ItemPropertyDarkvision();
    itemproperty ipImmuneCrit = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS);
    itemproperty ipImmuneDeath = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC);
    itemproperty ipImmuneDisease = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DISEASE);
    itemproperty ipImmuneDrain = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN);
    itemproperty ipImmuneMind = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS);
    itemproperty ipImmunePara = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_PARALYSIS);
    itemproperty ipImmunePoison = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_POISON);
    itemproperty ipSaveFort = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE, 20);
    itemproperty ipSaveWill = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL, 5);

    if (GetLocalInt(oPC, "IOP_CUST_UNDEAD") == FALSE)
    {
        //If the hide is invalid, create one and equip it.
        if (GetIsObjectValid(oHide) == FALSE)
        {
            oHide = CreateItemOnObject("potsc_pc_hide", oPC);
            RecurEquip(oPC, oHide, INVENTORY_SLOT_CARMOUR);
        }

        //Add item properties to the existing player hide.
        AddItemProperty(DURATION_TYPE_PERMANENT, ipRegen, oHide);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipWeapProfCre, oHide);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipWeapProfSim, oHide);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipDarkvision, oHide);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipImmuneCrit, oHide);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipImmuneDeath, oHide);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipImmuneDisease, oHide);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipImmuneDrain, oHide);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipImmuneMind, oHide);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipImmunePara, oHide);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipImmunePoison, oHide);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipSaveFort, oHide);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipSaveWill, oHide);



        sRace = GetLocalString(oPC, "ORIGINAL_SUBCLASS");
        if (sRace == "")
        {
            SetLocalString(oPC, "ORIGINAL_SUBCLASS", GetSubRace(oPC));
        }

        SetLocalInt(oPC, "IOP_CUST_UNDEAD", TRUE);
        SetSubRace(oPC, "Undead");
        ApplyVFXEyes(oPC);

        //Calculate their new HP (based on a 12-side hit die)
        while (iHitDieCounter < iHitDie)
        {
            iNewMaxHP = iNewMaxHP + Random(12);

            //Update the loop variable
            iHitDieCounter++;
        }
        //Add the new HP, provided it benefits the player.
        if (iNewMaxHP > iOldMaxHP)
        {
            eHitDie = EffectTemporaryHitpoints(iNewMaxHP - iOldMaxHP);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHitDie, oPC);
        }
    }
}

void RemoveUndead (object oPC)
{
    object oHide;
    string sRace;
    effect eCursor;

    oHide = GetItemPossessedBy(oPC, "potsc_pc_hide");
    if (GetIsObjectValid(oHide) == TRUE)
    {
        DestroyObject(oHide);
    }

    sRace = GetLocalString(oPC, "ORIGINAL_SUBCLASS");
    if (sRace == "Undead")
    {
        SetLocalString(oPC, "ORIGINAL_SUBCLASS", "");
        SetSubRace(oPC, sRace);
    }

    if (GetLocalInt(oPC, "IOP_CUST_UNDEAD") == TRUE)
    {
        SetLocalInt(oPC, "IOP_CUST_UNDEAD", FALSE);

        eCursor = GetFirstEffect(oPC);
        while (GetIsEffectValid(eCursor) == TRUE)
        {
            DelayCommand(0.1f, RemoveEffect(oPC, eCursor));
            eCursor = GetNextEffect(oPC);
        }
    }
}


