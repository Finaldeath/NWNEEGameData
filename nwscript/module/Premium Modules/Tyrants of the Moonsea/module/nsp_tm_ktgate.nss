//Scale up Creature posing as Kar-Tharsu Stronghold main gate
void main()
{
    effect eParalyze = SupernaturalEffect(EffectParalyze());

    SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_SCALE, 2.5);

    //Paralyse to prevent door attacking
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eParalyze, OBJECT_SELF);
}
