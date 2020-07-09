//::///////////////////////////////////////////////
//::
//:: c3_bw_trap_trig
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Trap Triggered script for special traps.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 11/4/2005
//::
//:://////////////////////////////////////////////

void DoBlockTrap();

void DoFireRound(object oTarget);

void DoWallSpikeTrap(object oTarget);

void DoBladeTrap();

void main()
{
    object oEnterer = GetEnteringObject();
    string sTag = GetTag(OBJECT_SELF);

    if (sTag == "bw_block_trap")
    {
        AssignCommand(oEnterer, ClearAllActions());

        object oBlock = GetNearestObjectByTag("bw_fall_block");
        object oLander = GetNearestObjectByTag("bw_block_land");

        location lLoc = GetLocation(oBlock);
        CreateObject(OBJECT_TYPE_PLACEABLE, "bw_barrier", lLoc);

        AssignCommand(oBlock, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));

        AssignCommand(oLander, DelayCommand(0.3, DoBlockTrap()));
    }
    else if (sTag == "bw_volley_trap")
    {
        object oFalseDoor = GetNearestObjectByTag("bw_false_door");
        object oShooter = GetNearestObjectByTag("bw_shooter");

        if (GetLocalInt(oFalseDoor, "nOpen") == 0)
        {
            AssignCommand(oFalseDoor, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
            SetLocalInt(oFalseDoor, "nOpen", 1);
        }

        AssignCommand(oShooter, DelayCommand(0.3, DoFireRound(oEnterer)));
        AssignCommand(oShooter, DelayCommand(0.7, DoFireRound(oEnterer)));
        AssignCommand(oShooter, DelayCommand(1.1, DoFireRound(oEnterer)));
        AssignCommand(oShooter, DelayCommand(1.5, DoFireRound(oEnterer)));
        AssignCommand(oShooter, DelayCommand(1.9, DoFireRound(oEnterer)));
    }
    else if (sTag == "bw_wallspike_trap")
    {
        object oSpike = GetNearestObjectByTag("bw_wallspike");
        AssignCommand(oSpike, DoWallSpikeTrap(oEnterer));
    }
    else if (sTag == "bw_blade_trap")
    {
        object oSpike = GetNearestObjectByTag("bw_blade");
        AssignCommand(oSpike, DoBladeTrap());
    }
    else if (sTag == "bw_false_door")
    {
        object oSpike = GetNearestObjectByTag("bw_wallspike");
        DelayCommand(0.4, AssignCommand(oSpike, DoWallSpikeTrap(oEnterer)));
        if (GetLocalInt(OBJECT_SELF, "nOpen") == 0)
        {
            PlayAnimation(ANIMATION_PLACEABLE_OPEN);
            SetLocalInt(OBJECT_SELF, "nOpen", 1);
        }
    }

    return;
}

void DoBlockTrap()
{
    // need a delay here?
    DelayCommand(0.1, PlaySound("as_na_stonefall"));

    int nNth = 1;
    object oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, nNth);
    float fDist = GetDistanceToObject(oCreature);
    int nSave;

    // trap variables
    int nDC = 18;
    float fRange = 5.0f;
    int nDam;

    effect eDam;
    effect eKnock = EffectKnockdown();

    while (GetIsObjectValid(oCreature) && (fDist > -1.0f) && (fDist < fRange))
    {
        if (GetIsPC(oCreature))
        {
            effect eBump = EffectVisualEffect(VFX_FNF_SCREEN_BUMP );
            DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBump, oCreature));
        }

        nSave = ReflexSave(oCreature, nDC, SAVING_THROW_TYPE_TRAP);

        if (nSave == 0) // fail, get crushed and knocked down!
        {
            nDam = d8(6);

            if (GetHasFeat(FEAT_IMPROVED_EVASION, oCreature))
            {
                nDam = FloatToInt(IntToFloat(nDam) * 0.5);
            }

            eDam = EffectDamage(nDam, DAMAGE_TYPE_BLUDGEONING);

            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oCreature);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnock, oCreature, 5.0f);
        }
        else if (nSave == 1) // save, suffer some flying debris
        {
            nDam = d8();

            if (GetHasFeat(FEAT_EVASION, oCreature))
            {
                nDam = FloatToInt(IntToFloat(nDam) * 0.5);
            }

            eDam = EffectDamage(nDam, DAMAGE_TYPE_BLUDGEONING);

            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oCreature);
        }

        nNth += 1;

        oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, nNth);
        fDist = GetDistanceToObject(oCreature);
    }
}

void DoFireRound(object oTarget)
{
    effect eArrow = EffectVisualEffect(VFX_IMP_MIRV_FLAME);

    int nHit = 0;
    int nAttack = d20();
    int nBonus = 10; // bonus to attack

    if (!LineOfSightObject(OBJECT_SELF, oTarget))
    {
        nHit = 0;
    }
    else if (nAttack == 0) // automatic miss
    {
        nHit = 0;
    }
    else if (nAttack == 20) // automatic hit
    {
        nHit = 1;
    }
    else
    {
        nAttack += nBonus;

        int nAC = GetAC(oTarget);

        if (nAttack >= nAC)
        {
            nHit = 1;
        }
    }

    if (nHit == 0)
    {
        eArrow = EffectVisualEffect(VFX_IMP_MIRV_FLAME, TRUE);
    }

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eArrow, oTarget);

    if (nHit == 1)
    {
        int nDamage = d8();
        int nFireDamage = d8();

        effect eFlame = EffectVisualEffect(VFX_IMP_FLAME_S );

        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING);
        effect eFireDam = EffectDamage(nFireDamage, DAMAGE_TYPE_FIRE);

        DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFlame, oTarget));
        DelayCommand(1.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
        DelayCommand(1.4, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFireDam, oTarget));
    }
}

void DoWallSpikeTrap(object oTarget)
{
    // trap variables
    int nDC = 16;
    int nDam = d6(6);
    effect eDam;

    effect eTrapFX = EffectVisualEffect(VFX_IMP_WALLSPIKE);
    location lLoc = GetLocation(OBJECT_SELF);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eTrapFX, lLoc);

    effect eBlood = EffectVisualEffect(VFX_IMP_WALLSPIKE);

    int nSave = ReflexSave(oTarget, nDC, SAVING_THROW_TYPE_TRAP);

    if (nSave == 0) // fail, get skewered
    {
        if (GetHasFeat(FEAT_IMPROVED_EVASION, oTarget))
        {
            nDam = FloatToInt(IntToFloat(nDam) * 0.5);
        }

        eDam = EffectDamage(nDam, DAMAGE_TYPE_PIERCING);
        DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
    }
    else if (nSave == 1) // save, half damage
    {
        if (GetHasFeat(FEAT_EVASION, oTarget))
        {
            nDam = FloatToInt(IntToFloat(nDam) * 0.5);
        }

        eDam = EffectDamage(nDam, DAMAGE_TYPE_PIERCING);
        DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
    }
}

void DoBladeTrap()
{
    int nNth = 1;
    object oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, nNth);
    float fDist = GetDistanceToObject(oCreature);
    int nSave;

    effect eTrapFX = EffectVisualEffect(VFX_FNF_SWINGING_BLADE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eTrapFX, OBJECT_SELF);

    // trap variables
    int nDC = 16;
    float fRange = 6.0f;
    int nDam = d8(5);

    effect eDam;

    while (GetIsObjectValid(oCreature) && (fDist > -1.0f) && (fDist < fRange))
    {
        nSave = ReflexSave(oCreature, nDC, SAVING_THROW_TYPE_TRAP);

        if (nSave == 0) // fail, get slashed
        {
            if (GetHasFeat(FEAT_IMPROVED_EVASION, oCreature))
            {
                nDam = FloatToInt(IntToFloat(nDam) * 0.5);
            }

            eDam = EffectDamage(nDam, DAMAGE_TYPE_SLASHING);
            DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oCreature));
        }
        else if (nSave == 1) // save, half damage
        {
            if (GetHasFeat(FEAT_EVASION, oCreature))
            {
                nDam = FloatToInt(IntToFloat(nDam) * 0.5);
            }

            eDam = EffectDamage(nDam, DAMAGE_TYPE_SLASHING);
            DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oCreature));
        }

        nNth += 1;

        oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, nNth);
        fDist = GetDistanceToObject(oCreature);
    }
}
