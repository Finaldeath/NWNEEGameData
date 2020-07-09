int StartingConditional()
{
    object oEnemy = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE,
                                       OBJECT_SELF, 1,
                                       CREATURE_TYPE_REPUTATION,
                                       REPUTATION_TYPE_ENEMY);

    if(oEnemy == OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
