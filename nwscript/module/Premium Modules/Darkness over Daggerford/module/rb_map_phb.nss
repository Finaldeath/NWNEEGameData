void main()
{
    if(GetLocalInt(OBJECT_SELF, "iHeartbeat") == 1)
    {
        int i = 1;

        object oHostile = GetFirstPC();

        while(oHostile != OBJECT_INVALID)
        {
            oHostile = GetNearestCreature(CREATURE_TYPE_REPUTATION,
                                          REPUTATION_TYPE_ENEMY,
                                          GetFirstPC(),
                                          i);

            if(GetIsObjectValid(oHostile) &&
               GetAssociateType(oHostile) == ASSOCIATE_TYPE_NONE)
            {
                DestroyObject(oHostile);
            }

            i++;
        }
        DelayCommand(1.0, ExecuteScript("rb_map_phb", OBJECT_SELF));
    }

}
