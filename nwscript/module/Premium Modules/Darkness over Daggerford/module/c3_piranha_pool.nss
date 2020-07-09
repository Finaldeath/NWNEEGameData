// creatures inside the piranha pool take damage until they leave
// The pools are triggers with the following variables:
// .. POOL_TYPE = 1 | 2
// ..  - 1 = normal piranhas
// ..  - 2 = vicious piranhas

void Inside(object oPC, int nType)
{
    int nDmg;

    // what type of pool is this?
    object oPool = GetNearestObjectByTag("PiranhaPool", oPC);

    if (nType == 1)
    {
        nDmg = d6();
    }
    else
    {
        nDmg = d10();
    }

    string sTag = GetTag(oPC);
    //Kill the lizard priest quickly if piranhas put in his pool
    if(sTag == "lizpriest")
    {
        nDmg = 25;
    }
    else
    //Don't let henchmen die in pool or can be trapped forever
    if((sTag == "pm_raegen" || sTag == "ks_purfbin") &&
       GetCurrentHitPoints() < 15)
    {
        nDmg = 0;
    }
    else
    //Flying enemies shouldn't be affected
    if(sTag == "X0_WYRMLING_BLK" || sTag == "X0_WYRMLING_BLU" ||
       sTag == "X0_WYRMLING_GRN")
    {
        nDmg = 0;
    }

    if(nDmg > 0)
    {
        // apply "nibbling teeth" damage
        effect eDmg = EffectDamage(nDmg, DAMAGE_TYPE_PIERCING);

        // display "attacking piranha" vfx
        effect eVis = EffectVisualEffect(584);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);

        AssignCommand(oPool, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oPC));
    }
    // try again in a few seconds (should roughly match the VFX duration)
    DelayCommand(3.0, ExecuteScript("c3_piranha_pool", oPC));
}

// is an object inside a trigger?
int InsideObject(object oPC, object oTrig)
{
    object o = GetFirstInPersistentObject(oTrig);
    while (GetIsObjectValid(o))
    {
        if (oPC == o)
        {
            return(TRUE);
        }
        o = GetNextInPersistentObject(oTrig);
    }
    return(FALSE);
}

void main()
{
    object oPool = GetLocalObject(OBJECT_SELF, "nBitingFishPool");
    int nType = GetLocalInt(OBJECT_SELF, "nBitingFish");
    if (nType != 0 && InsideObject(OBJECT_SELF, oPool))
    {
        Inside(OBJECT_SELF, nType);
    }
}
