void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC))
    {
        SetLocalInt(oPC, "iDoorSouthSide", 1);
    }
}
