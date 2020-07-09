void main()
{
    SetIsDestroyable( FALSE, FALSE, TRUE );
    ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF ) ;
}

