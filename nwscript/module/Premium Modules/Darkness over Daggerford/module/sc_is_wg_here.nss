int StartingConditional()
{
    //true if white glove is in the area and checks it's a creature not the store

    object oWhite = GetNearestObjectByTag("db_whiteglove");
    if(GetIsObjectValid(oWhite) && GetObjectType(oWhite) == OBJECT_TYPE_CREATURE)
    return TRUE;
    return FALSE;
}
