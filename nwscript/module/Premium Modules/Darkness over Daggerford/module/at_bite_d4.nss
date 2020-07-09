//simulate insect bites
//Damian Brown (Luspr)
//Oct17 2005
void main()
{
    object oPC=GetPCSpeaker();
    int nDamage=d4(1);
    effect eOuch=EffectDamage(nDamage,DAMAGE_TYPE_PIERCING);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eOuch,oPC);
}
