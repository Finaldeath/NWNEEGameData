void main()
{
    object oDragon = GetObjectByTag("ac_blackdragon");

    if((GetLocalInt(oDragon, "nSurrendered") == 0) &&
       (!IsInConversation(oDragon)) &&
       (!GetIsInCombat(oDragon)))
    {
        object oSeen =
            GetNearestCreature(CREATURE_TYPE_REPUTATION,
                               REPUTATION_TYPE_NEUTRAL,
                               oDragon,
                               1,
                               CREATURE_TYPE_PERCEPTION,
                               PERCEPTION_SEEN);

        if(oSeen != OBJECT_INVALID)
        {
            AssignCommand(oDragon,SetFacingPoint(GetPosition(oSeen)));
        }
    }
    if(GetLocalInt(oDragon,"iHeartbeat") == 1)
    {
        DelayCommand(0.5f,
                ExecuteScript("rb_dragon_phb",oDragon));
    }
}
