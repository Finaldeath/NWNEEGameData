void KillTroll(int bFireDeath = FALSE, int bAcidDeath = FALSE)
{
    //PrintString("Troll killed!");
    SetImmortal(OBJECT_SELF, FALSE);
    effect eDeath = EffectDeath();

    if(bFireDeath == TRUE)
    {
        effect eFire = EffectVisualEffect(VFX_IMP_FLAME_M);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, OBJECT_SELF);
    }
    else
    if(bAcidDeath == TRUE)
    {
         effect eAcid = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID);
         ApplyEffectToObject(DURATION_TYPE_INSTANT, eAcid,OBJECT_SELF);
    }

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, OBJECT_SELF);
}

void GiveImmunity(object oTroll)
{
    effect eImmunity1 = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, 100);
    effect eImmunity2 = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 100);
    effect eImmunity3 = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, 100);
    effect eImmunity4 = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, 100);
    effect eImmunity5 = EffectDamageImmunityIncrease(DAMAGE_TYPE_DIVINE, 100);
    effect eImmunity6 = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, 100);
    effect eImmunity7 = EffectDamageImmunityIncrease(DAMAGE_TYPE_MAGICAL, 100);
    effect eImmunity8 = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, 100);
    effect eImmunity9 = EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE, 100);
    effect eImmunity10 = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC, 100);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmunity1, oTroll);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmunity2, oTroll);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmunity3, oTroll);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmunity4, oTroll);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmunity5, oTroll);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmunity6, oTroll);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmunity7, oTroll);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmunity8, oTroll);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmunity9, oTroll);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmunity10, oTroll);
}

void main()
{
    //PrintString("--------------");
    //PrintString("OnDamage event triggered");
    //PrintString("--------------");

    // remember how much fire and acid damage was done to this troll
    int nF = GetDamageDealtByType(DAMAGE_TYPE_FIRE);
    if (nF > 0)
    {
        //PrintString("Damaged by fire - " + IntToString(nF));
        int nFireDmg = GetLocalInt(OBJECT_SELF, "nFireDmg");
        SetLocalInt(OBJECT_SELF, "nFireDmg", nFireDmg + nF);
    }
    int nA = GetDamageDealtByType(DAMAGE_TYPE_ACID);
    if (nA > 0)
    {
        //PrintString("Damaged by acid - " + IntToString(nA));
        int nAcidDmg = GetLocalInt(OBJECT_SELF, "nAcidDmg");
        SetLocalInt(OBJECT_SELF, "nAcidDmg", nAcidDmg + nA);
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
        if(nA > 0 || nF > 0)
        {
            if(nF >= nA)
            {
                //PrintString("Fire Damage when knocked down - death occurs!");
                KillTroll(TRUE);
            }
            else
            {
                //PrintString("Acid Damage when knocked down - death occurs!");
                KillTroll(FALSE, TRUE);
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

    int nFireDmg = GetLocalInt(OBJECT_SELF, "nFireDmg");
    int nAcidDmg = GetLocalInt(OBJECT_SELF, "nAcidDmg");

    //PrintString("Fire/Acid running total = " + IntToString(nFireDmg + nAcidDmg));

    //Destroy if it's taken fire/acid damage greater than its hit points
    if(nFireDmg + nAcidDmg >= GetMaxHitPoints(OBJECT_SELF))
    {
        //Determine whether fire/acid damage was greater this round and
        //destroy with appropriate effect
        if(nF >= nA)
        {

            //PrintString("All damage taken from fire/acid, fire death occurs");
            KillTroll(TRUE);
        }
        else
        {
            //PrintString("All damage taken from fire/acid, acid death occurs");
            KillTroll(FALSE, TRUE);
        }
    }
    else
    if(GetLocalInt(OBJECT_SELF, "nTrackedHP") < 1 &&
       GetLocalInt(OBJECT_SELF, "nKnockdown") == 0)
    {
        effect eParalyze = EffectCutsceneParalyze();
        object oTroll = OBJECT_SELF;
        //PrintString("Knockdown!");

       /* int dur = (abs(GetLocalInt(OBJECT_SELF, "nTrackedHP")) + 1) / 5;
        if(((abs(GetLocalInt(OBJECT_SELF, "nTrackedHP")) + 1) % 5) > 0)
        {
            dur++;
        }
        PrintString("Knockdown duration = " + IntToString(dur));
        if(dur < 4)
            dur = 4;
        PrintString("Amended Knockdown duration = " + IntToString(dur));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(),OBJECT_SELF, RoundsToSeconds(dur));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eParalyze, OBJECT_SELF, RoundsToSeconds(dur));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectImmunity(IMMUNITY_TYPE_KNOCKDOWN),OBJECT_SELF, RoundsToSeconds(dur));
         */
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectKnockdown(),OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eParalyze, OBJECT_SELF);
        AssignCommand(GetObjectByTag("EffectApplier"), GiveImmunity(oTroll));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectImmunity(IMMUNITY_TYPE_KNOCKDOWN), OBJECT_SELF);
        SetLocalInt(OBJECT_SELF, "nKnockdown", 1);
        int nKnockdownCount = GetLocalInt(OBJECT_SELF, "nKnockdownCount");
        nKnockdownCount++;
        //PrintString("Knockdown count = " + IntToString(nKnockdownCount));
        SetLocalInt(OBJECT_SELF, "nKnockdownCount", nKnockdownCount);
        if(nKnockdownCount > 4)
        {
            //PrintString("Knockdown limit reached - death occurs");
            KillTroll();
        }
    }
    //PrintString("--------------");
    //PrintString("OnDamage event ends");
    //PrintString("--------------");
    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------
    ExecuteScript("nw_c2_default6", OBJECT_SELF);
}
