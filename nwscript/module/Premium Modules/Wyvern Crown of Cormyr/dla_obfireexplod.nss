// Explosion for an oli barrel

void main()
{
        if (GetDamageDealtByType(DAMAGE_TYPE_FIRE)>0)
        {
        DelayCommand(3.0,ActionCastSpellAtObject(SPELL_FIREBALL,OBJECT_SELF,METAMAGIC_NONE,TRUE,0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
        DelayCommand(3.2,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(30),OBJECT_SELF));
        }
}
