//Valda and the Forsaken become friendly towards the PC

void main()
{
    object oPC = GetPCSpeaker();
    object oRider;

    location lValda = GetLocation(OBJECT_SELF);

    SetIsTemporaryFriend(oPC, OBJECT_SELF);

    oRider = GetFirstObjectInShape(SHAPE_SPHERE, 25.0, lValda, FALSE, OBJECT_TYPE_CREATURE);

    while(oRider != OBJECT_INVALID)
    {
        if(GetTag(oRider) == "Forsaken")
        {
            SetIsTemporaryFriend(oPC, oRider);
        }
        oRider = GetNextObjectInShape(SHAPE_SPHERE, 25.0, lValda, FALSE, OBJECT_TYPE_CREATURE);
    }
}
