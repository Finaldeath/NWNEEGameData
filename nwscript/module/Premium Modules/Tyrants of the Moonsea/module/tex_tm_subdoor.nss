void main()
{
    object oPC = GetExitingObject();

    if(GetIsPC(oPC))
    {
        SetLocalInt(oPC, "iDoorSouthSide", 0);
    }
}
