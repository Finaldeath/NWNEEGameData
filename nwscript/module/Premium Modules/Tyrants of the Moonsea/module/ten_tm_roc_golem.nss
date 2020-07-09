// spawn the golem in the ruins of candlemas

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nDone", 1);
            object oWP = GetNearestObjectByTag("WP_THRC_GOLEM");
            location lLoc = GetLocation(oWP);
            object oGolem = CreateObject(OBJECT_TYPE_CREATURE, "nw_goldmflesh001", lLoc);
            AssignCommand(oGolem, PlaySound("c_goldem_bat1"));
            effect eVfx1 = EffectVisualEffect(VFX_FNF_SUMMONDRAGON);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVfx1, lLoc);
            effect eVfx2 = EffectVisualEffect(VFX_FNF_LOS_EVIL_10);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVfx2, lLoc);
        }
    }
}
