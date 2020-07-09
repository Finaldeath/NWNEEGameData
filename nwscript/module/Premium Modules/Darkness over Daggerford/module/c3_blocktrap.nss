// a giant stone block falls on the player

void DoBlockTrap()
{
    DelayCommand(0.1, PlaySound("as_na_stonefall"));

    int nNth = 1;
    object oCreature = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,nNth);//GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, nNth);
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

        oCreature = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,nNth);//GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, nNth);
        fDist = GetDistanceToObject(oCreature);
    }
}

void main()
{
    object oBlock = GetNearestObjectByTag("bw_fall_block");
    object oLander = GetNearestObjectByTag("bw_block_land");

    location lLoc = GetLocation(oBlock);
    CreateObject(OBJECT_TYPE_PLACEABLE, "bw_barrier", lLoc);
    SetCommandable(TRUE, GetPCSpeaker());

    AssignCommand(oBlock, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    AssignCommand(oLander, DelayCommand(0.3, DoBlockTrap()));
}
