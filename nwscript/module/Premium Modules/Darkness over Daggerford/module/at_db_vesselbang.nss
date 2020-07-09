void main()
{
    location lBadoom=GetLocation(OBJECT_SELF);
    ActionCastSpellAtLocation(SPELL_FIREBALL,lBadoom,METAMAGIC_NONE,
    1,PROJECTILE_PATH_TYPE_DEFAULT,1);
    object oVessel=OBJECT_SELF;
    object oFlame=GetObjectByTag("db_vesflame");
    object oAltar=GetObjectByTag("AltarShrineEvil");
    DelayCommand(0.3,DestroyObject(oVessel));
    DelayCommand(0.3,DestroyObject(oFlame));
    DelayCommand(0.3,DestroyObject(oAltar));
}
