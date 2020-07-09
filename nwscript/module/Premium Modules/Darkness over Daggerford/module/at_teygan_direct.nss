void main()
{
    //give the pc the directions to the 2 caravans
    if(GetLocalInt(OBJECT_SELF, "iGivenDirections") == 0)
    {
        object oPC=GetPCSpeaker();
        CreateItemOnObject("db_directions",oPC,1);
        SetLocalInt(OBJECT_SELF, "iGivenDirections", 1);
    }
}
