void main()
{
    object oPC = GetClickingObject();

    if(GetIsPC(oPC))
    {
        if(GetLocalInt(oPC, "iDoorSouthSide") == 1)
        {
            FloatingTextStringOnCreature("This heavy iron door appears to " +
                                         "have been barricaded from the other side.", oPC);
        }
        else
        {
            FloatingTextStringOnCreature("The bookcase has been used as a barricade " +
                                         "to prevent the door from opening." , oPC);
        }
    }
}
