void main()
{
  object oClicker = GetLastUsedBy();
  location lTarget = GetLocation(GetWaypointByTag("wp_1308teleport2"));

  //SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);
    if (GetIsPC(oClicker))
    {
        int i, j;
        object oAssoc;
        // loop through all associate types
        // ASSOCIATE_TYPE_HENCHMAN         = 1;
        // ASSOCIATE_TYPE_ANIMALCOMPANION  = 2;
        // ASSOCIATE_TYPE_FAMILIAR         = 3;
        // ASSOCIATE_TYPE_SUMMONED         = 4;
        // ASSOCIATE_TYPE_DOMINATED        = 5;

        AssignCommand(oClicker, ClearAllActions());
        AssignCommand(oClicker, ActionJumpToLocation(lTarget));

        for (j=1; j<6; j++)
        {
            i = 1;
            oAssoc = GetAssociate(j, oClicker, i);
            while (oAssoc != OBJECT_INVALID)
            {
                AssignCommand(oAssoc, JumpToLocation(lTarget));
                i++; // loop through all associates of type j by increasing value of i
                oAssoc = GetAssociate(j, oClicker, i);
            }
        }
    }
}
