void main()
{
    object oPC = GetFirstPC();
    location lLoc = GetLocation(oPC);
    int i;
    for (i=1; i<=5; i++)
    {
        CreateObject(OBJECT_TYPE_CREATURE, "nw_orca", lLoc);
    }
}
