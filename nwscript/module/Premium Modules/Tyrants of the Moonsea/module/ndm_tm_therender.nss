
// Will be immune to all types of damage except the following two
const int    TYPE_EFFECTIVE_DAMAGE_A = DAMAGE_TYPE_ELECTRICAL;
const string LVAR_EFFECTIVE_DAMAGE_A = "effective_dam_a";
const int    DEATH_VFX_DAMAGE_A = VFX_IMP_LIGHTNING_S;

const int    TYPE_EFFECTIVE_DAMAGE_B = 8192; // 8192 is never used = no 2nd damage vulnerability
const string LVAR_EFFECTIVE_DAMAGE_B = "effective_dam_b";
const int    DEATH_VFX_DAMAGE_B = VFX_IMP_LIGHTNING_S;

void KillTarget(int nSpectacularDamage = 0)
{
    SetImmortal(OBJECT_SELF, FALSE);
    effect eDeath = EffectDeath();

    if (nSpectacularDamage & TYPE_EFFECTIVE_DAMAGE_A)
    {
        effect eDeathVFX = EffectVisualEffect(DEATH_VFX_DAMAGE_A);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeathVFX, OBJECT_SELF);
    }
    else if (nSpectacularDamage & TYPE_EFFECTIVE_DAMAGE_B)
    {
         effect eDeathVFX = EffectVisualEffect(DEATH_VFX_DAMAGE_B);
         ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeathVFX, OBJECT_SELF);
    }

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, OBJECT_SELF);
}


// Give oTarget 100% immunity against all damage types except excluded ones
// Exclude multiple daamge types with bitwise OR
void GiveImmunity(object oTarget, int nExcludedDamage = 0)
{
    int nDamageType = 0;
    effect eImmunity;
    for (nDamageType = 1; nDamageType < DAMAGE_TYPE_BASE_WEAPON; nDamageType << 2)
    {
        if (!(nDamageType & nExcludedDamage))
        {
            eImmunity = EffectDamageImmunityIncrease(nDamageType, 100);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmunity, oTarget);
        }
    }
}


void main()
{
    //PrintString("--------------");
    //PrintString("OnDamage event triggered");
    //PrintString("--------------");

    // Save total damage dealt by effective types
    int nNewDamageA = GetDamageDealtByType(TYPE_EFFECTIVE_DAMAGE_A);
    if (nNewDamageA > 0)
    {
        //PrintString("Damaged by A - " + IntToString(nNewDamageA));
        int nOldDamageA = GetLocalInt(OBJECT_SELF, LVAR_EFFECTIVE_DAMAGE_A);
        SetLocalInt(OBJECT_SELF, LVAR_EFFECTIVE_DAMAGE_A, nOldDamageA + nNewDamageA);
    }
    int nNewDamageB = GetDamageDealtByType(TYPE_EFFECTIVE_DAMAGE_B);
    if (nNewDamageB > 0)
    {
        //PrintString("Damaged by B - " + IntToString(nNewDamageB));
        int nOldDamageB = GetLocalInt(OBJECT_SELF, LVAR_EFFECTIVE_DAMAGE_B);
        SetLocalInt(OBJECT_SELF, LVAR_EFFECTIVE_DAMAGE_B, nOldDamageB + nNewDamageB);
    }

    if(GetLocalInt(OBJECT_SELF, "nKnockdown") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nTrackedHP",
                    GetLocalInt(OBJECT_SELF, "nTrackedHP") - GetTotalDamageDealt());
        //PrintString("Damaged for " + IntToString(GetTotalDamageDealt()));
        //PrintString("Tracked hp = " + IntToString(GetLocalInt(OBJECT_SELF, "nTrackedHP")));
    }
    else
    //If on zero or fewer hit points and take fire/acid damage, death occurs
    {
        if(nNewDamageA > 0 || nNewDamageB > 0)
        {
            if(nNewDamageA >= nNewDamageB)
            {
                KillTarget(TYPE_EFFECTIVE_DAMAGE_A);
            }
            else
            {
                KillTarget(TYPE_EFFECTIVE_DAMAGE_B);
            }
        }
        else
        {
            //PrintString("Not taking " + IntToString(GetTotalDamageDealt()) + " damage when knocked down");
            //Restore hit points to tracked value
            int nCurHP = GetCurrentHitPoints(OBJECT_SELF);
            //PrintString("Current hp = " + IntToString(nCurHP));
            int nTrackedHP = GetLocalInt(OBJECT_SELF, "nTrackedHP");
            //PrintString("Tracked hp = " + IntToString(nTrackedHP));
            int nRestoreHP = nTrackedHP - nCurHP;
            if(nRestoreHP > 0)
            {
                effect eHeal = EffectHeal(nRestoreHP);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
            }
            //PrintString("I can't be damaged when knocked down, so restored hit points = " +
            //             IntToString(nRestoreHP));
         }
    }

    int nTotalDamageA = GetLocalInt(OBJECT_SELF, LVAR_EFFECTIVE_DAMAGE_A);
    int nTotalDamageB = GetLocalInt(OBJECT_SELF, LVAR_EFFECTIVE_DAMAGE_B);

    //PrintString("Fire/Acid running total = " + IntToString(nFireDmg + nAcidDmg));

    //Destroy if it's taken fire/acid damage greater than its hit points
    if(nTotalDamageA + nTotalDamageB >= GetMaxHitPoints(OBJECT_SELF))
    {
        //Determine whether fire/acid damage was greater this round and
        //destroy with appropriate effect
        if (nNewDamageA >= nNewDamageB)
        {
            KillTarget(TYPE_EFFECTIVE_DAMAGE_A);
        }
        else
        {
            KillTarget(TYPE_EFFECTIVE_DAMAGE_B);
        }
    }
    else
    if(GetLocalInt(OBJECT_SELF, "nTrackedHP") < 1 &&
       GetLocalInt(OBJECT_SELF, "nKnockdown") == 0)
    {
        effect eParalyze = EffectCutsceneParalyze();
        object oTroll = OBJECT_SELF;

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectKnockdown(),OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eParalyze, OBJECT_SELF);
        AssignCommand(GetObjectByTag("EffectApplier"), GiveImmunity(oTroll, (TYPE_EFFECTIVE_DAMAGE_A| TYPE_EFFECTIVE_DAMAGE_B) ));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectImmunity(IMMUNITY_TYPE_KNOCKDOWN), OBJECT_SELF);
        SetLocalInt(OBJECT_SELF, "nKnockdown", 1);
        int nKnockdownCount = GetLocalInt(OBJECT_SELF, "nKnockdownCount");
        nKnockdownCount++;

        SetLocalInt(OBJECT_SELF, "nKnockdownCount", nKnockdownCount);
        if(nKnockdownCount > 4)
        {
            KillTarget();
        }
    }
    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------
    ExecuteScript("nw_c2_default6", OBJECT_SELF);
}
