// B W-Husey
//October 2005
// This trigger tells a hidden 'archer' (invisible object) to fire an arrow. The tag of the trigger and object should match.

void main()
{
    object oTarget = GetEnteringObject();
    object oArcher = GetNearestObjectByTag(GetTag(OBJECT_SELF),OBJECT_SELF,1);
    int nRand = Random(3);
    if (GetFactionEqual(oTarget,OBJECT_SELF)!=TRUE && nRand==1)
    {
        AssignCommand(oArcher,ActionCastSpellAtObject(SPELL_ICE_DAGGER, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT));
    }
}
