// sets the name of the current dialog branch
// ... names are useful for multiple skill check types per dialog
void SkillSetBranchName(object oPC, object oNPC, string sName)
{
    SetLocalString(oNPC, "HF_SKILL_BRANCH_NAME", sName);
}

// sets the index (SKILL_) of the current skill attempt
void SkillSetSkillNum(object oPC, object oNPC, int nSkill)
{
    SetLocalInt(oNPC, "HF_SKILL_NUM", nSkill);
}

// gets the index (SKILL_) of the current skill attempt
int SkillGetSkillNum(object oPC, object oNPC)
{
    return(GetLocalInt(oNPC, "HF_SKILL_NUM"));
}

// did the last skill check fail?
int SkillDidLastCheckFail(object oPC, object oNPC, int nSkill)
{
    string sBranch = GetLocalString(oNPC, "HF_SKILL_BRANCH_NAME");
    string sId = "sSkill_" + IntToString(nSkill) + "_" + sBranch + "_" + ObjectToString(oPC);
    int nLastResult = GetLocalInt(oNPC, sId);
    return(nLastResult == -1);
}

// did the last skill check pass?
int SkillDidLastCheckPass(object oPC, object oNPC, int nSkill)
{
    string sBranch = GetLocalString(oNPC, "HF_SKILL_BRANCH_NAME");
    string sId = "sSkill_" + IntToString(nSkill) + "_" + sBranch + "_" + ObjectToString(oPC);
    int nLastResult = GetLocalInt(oNPC, sId);
    return(nLastResult > 0);
}

// can the player attempt the skill check?
int SkillCanAttempt(object oPC, object oNPC, int nSkill)
{
    string sBranch = GetLocalString(oNPC, "HF_SKILL_BRANCH_NAME");
    string sId = "sSkill_" + IntToString(nSkill) + "_" + sBranch + "_" + ObjectToString(oPC);
    int nLastResult = GetLocalInt(oNPC, sId);
    return(nLastResult == 0);
}

// record the result of the skill check
void SkillSetResult(object oPC, object oNPC, int nSkill, int nResult)
{
    string sBranch = GetLocalString(oNPC, "HF_SKILL_BRANCH_NAME");
    string sId = "sSkill_" + IntToString(nSkill) + "_" + sBranch + "_" + ObjectToString(oPC);
    SetLocalInt(oNPC, sId, nResult);
}

// is the player allowed to retry skill checks against this creature?
int SkillCanRetry(object oPC, object oNPC, int nSkill)
{
    if (GetLocalInt(oNPC, "HF_SKILL_ALLOW_RETRIES") == 0 &&
        GetLocalInt(GetModule(), "HF_SKILL_ALLOW_RETRIES") == 0)
    {
        return(FALSE);
    }
    return(TRUE);
}

// return the DC for the current skill attempt
int SkillGetDC(object oPC, object oNPC, int nSkill)
{
    int nAdjust = 0;
    int nDC = GetLocalInt(OBJECT_SELF, "HF_SKILL_DC");
    if (nDC <= 0)
    {
        nDC = GetLocalInt(GetModule(), "HF_SKILL_DC");
    }
    if (nDC <= 0)
    {
        nDC = 10;
    }

    if (nSkill == SKILL_APPRAISE)
    {
        nDC += GetSkillRank(SKILL_APPRAISE, oNPC);
    }
    else if (nSkill == SKILL_INTIMIDATE)
    {
        nDC += GetHitDice(oNPC);
    }
    else if (nSkill == SKILL_PERSUADE || nSkill == SKILL_BLUFF)
    {
        nDC += GetAbilityModifier(ABILITY_INTELLIGENCE, oNPC);
    }
    else if (nSkill == SKILL_SPOT)
    {
        nDC += GetSkillRank(SKILL_HIDE, oNPC) + GetAbilityModifier(ABILITY_DEXTERITY, oNPC);
    }
    else if (nSkill == SKILL_PICK_POCKET)
    {
        nDC += GetSkillRank(SKILL_SPOT, oNPC) + GetAbilityModifier(ABILITY_WISDOM);
    }

    return(nDC);
}

// applies the effects (if any) of a successful skill check
void SkillApplyEffects(object oPC, object oNPC, int nSkill)
{
    if (nSkill == SKILL_TAUNT)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACDecrease(3), oNPC, 30.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSpellFailure(30), oNPC, 30.0);
    }
}

// returns true if the skill check succeeds
int SkillCheck(object oPC, object oNPC, int nSkill, int nPass=FALSE)
{
    effect eSuccess = EffectVisualEffect(VFX_IMP_HEAD_MIND);
    effect eFail = EffectVisualEffect(VFX_IMP_HEAD_EVIL);

	// always succeed if we succeeded the last time
    if (SkillDidLastCheckPass(oPC, oNPC, nSkill) > 0)
    {
        return(TRUE);
    }

    // always fail if we failed the last time
    if (!SkillCanRetry(oPC, oNPC, nSkill))
    {
        if (SkillDidLastCheckFail(oPC, oNPC, nSkill))
            return(FALSE);
    }

    // make the skill check
    int nSuccess;
    if (!nPass)
    {
        // roll the dice to see if we pass
        int nDC = SkillGetDC(oPC, oNPC, nSkill);
        nSuccess = ((d20() + GetSkillRank(nSkill, oPC)) >= nDC);
    }
    else
    {
        // the skill check must pass
        nSuccess = TRUE;
    }

    // give XP for a successul skill check
    if (nSuccess)
    {
        if (!GetLocalInt(oNPC, "HF_SKILL_NO_XP"))
        {
            int nXP = GetLocalInt(oNPC, "HF_SKILL_XP");
            if (nXP <= 0)
            {
                nXP = GetLocalInt(GetModule(), "HF_SKILL_XP");
            }
            if (nXP > 0)
            {
                GiveXPToCreature(oPC, nXP);
            }
        }
        FloatingTextStringOnCreature("*** Success ***", oPC);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, eSuccess, oPC);
		SkillSetResult(oPC, oNPC, nSkill, 1);
        SkillApplyEffects(oPC, oNPC, nSkill);
        return(TRUE);
    }

    // check failed
    FloatingTextStringOnCreature("*** Failed ***", oPC);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eFail, oPC);
	SkillSetResult(oPC, oNPC, nSkill, -1);
    return(FALSE);
}

int SkillCheckFail(object oPC, object oNPC, int nSkill)
{
    effect eFail = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
	FloatingTextStringOnCreature("*** Failed ***", oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFail, oPC);
	SkillSetResult(oPC, oNPC, nSkill, -1);
    return(FALSE);
}

/*
OBJECT:
  HF_SKILL_NUM : the skill number to use in this check
  HF_SKILL_BRANCH_NAME : branch identifier for this skill check
  HF_SKILL_XP : XP for all skill checks against this creature
  HF_SKILL_DC : base DC for all skill checks against this creature
  HF_SKILL_ALLOW_RETRIES : true to allow retries for all skills

MODULE:
  HF_SKILL_XP : default amount of XP given for successful skill checks
  HF_SKILL_DC : default base DC for all skill checks in the game
  HF_SKILL_ALLOW_RETRIES : true to allow retries for all skill checks
*/

