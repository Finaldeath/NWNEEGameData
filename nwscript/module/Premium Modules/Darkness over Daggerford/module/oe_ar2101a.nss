void main()
{
    //set an int to say that the player has discoverd the drop off cave
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) && !GetLocalInt(GetModule(), "drop_off_empty") ==1)
    {
        SetLocalInt(GetModule(), "drop_off_empty", 1);
    }
}
