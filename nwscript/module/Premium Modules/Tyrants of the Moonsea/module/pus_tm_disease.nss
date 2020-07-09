//Corpse in Slaad Hut infects with Red Slaad Eggs disease
void main()
{
    object oPC = GetLastUsedBy();

    effect eDisease = EffectDisease(DISEASE_RED_SLAAD_EGGS);

    if(GetLocalInt(OBJECT_SELF, "nUsed") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nUsed", 1);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDisease, oPC);
    }
}
