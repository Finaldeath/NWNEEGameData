//Tr-Flower Frond OnSpawn
void main()
{
    effect eGhost = EffectCutsceneGhost();

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);
}
