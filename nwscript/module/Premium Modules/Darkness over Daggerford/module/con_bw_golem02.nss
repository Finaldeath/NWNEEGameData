void main()
{
    object oFissure = GetObjectByTag("ar2503_fissure");
    ActionForceMoveToObject(oFissure, FALSE, 1.0f, 240.0f);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 0.6f, 1.5f);
    ActionDoCommand(DestroyObject(oFissure));
}
