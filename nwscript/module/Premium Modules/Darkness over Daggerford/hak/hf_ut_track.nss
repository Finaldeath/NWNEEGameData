void GiveXP(object oPC)
{
    int nXP = GetLocalInt(OBJECT_SELF, "HF_SKILL_XP");
    if (nXP == 0)
        nXP = GetLocalInt(GetModule(), "HF_SKILL_XP");
    if (nXP > 0)
        GiveXPToCreature(oPC, nXP);
}

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    int nResult = FALSE;

    // were these tracks already read?
    int nExamined = GetLocalInt(OBJECT_SELF, "HF_EXAMINED");
    if ( nExamined == 1)
    {
        return(TRUE);
    }
    else if (nExamined == -1)
    {
        return(FALSE);
    }

    // determine DC (default of 10)
    int nDC = GetLocalInt(OBJECT_SELF, "HF_SKILL_DC");
    if (nDC == 0)
        nDC = 10;

    // determine bonuses
    int nBonus = 0;
    if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) > 0)
    {
        nBonus = 6;
    }
    else if (GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC) > 3 &&
             GetIsAreaAboveGround(oArea) && GetIsAreaNatural(oArea))
    {
        nBonus = 6;
    }
    else if (GetLevelByClass(CLASS_TYPE_DRUID, oPC) > 0 &&
             GetIsAreaNatural(oArea))
    {
        nBonus = 2;
    }
    else if (GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC) > 0)
    {
        nBonus = 2;
    }

    // roll skill check
    int nRoll = d20() + GetAbilityModifier(ABILITY_WISDOM, oPC);
    if (nRoll >= nDC)
    {
        FloatingTextStringOnCreature("Tracking: Success", oPC);
        SetLocalInt(OBJECT_SELF, "HF_EXAMINED", 1);
        GiveXP(oPC);
        nResult = TRUE;
    } else {
        FloatingTextStringOnCreature("Tracking: Failure", oPC);
        SetLocalInt(OBJECT_SELF, "HF_EXAMINED", -1);
        nResult = FALSE;
    }
    return(nResult);
}
