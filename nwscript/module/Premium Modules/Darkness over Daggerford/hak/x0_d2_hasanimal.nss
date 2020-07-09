// if can summon animal companion

int StartingConditional()
{
    object o = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, OBJECT_SELF, 1);
    if (GetIsObjectValid(o))
    {
        return(FALSE);
    }
    return(GetHasFeat(FEAT_ANIMAL_COMPANION, OBJECT_SELF));
}
