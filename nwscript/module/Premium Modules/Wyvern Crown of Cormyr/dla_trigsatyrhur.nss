// March 2006
// B W-Husey
// Sets up the tortured prisoner

void main()
{
    if (GetLocalInt(OBJECT_SELF,"nOnce")<1)
    {
    object oSat = GetNearestObjectByTag("SatyrPrisoner") ;
    effect eDam = EffectDamage(18);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oSat);
    AssignCommand(oSat,ClearAllActions(TRUE));
    SetLocalInt(OBJECT_SELF,"nOnce",1);
    DestroyObject(OBJECT_SELF); //We don't want him to take damage 10 times!
    }
}
