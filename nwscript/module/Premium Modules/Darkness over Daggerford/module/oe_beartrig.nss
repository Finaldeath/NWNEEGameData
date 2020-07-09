void main()
{
    object oPC=GetEnteringObject();
    if(GetIsPC(oPC)&&!GetLocalInt(GetModule(),"super_bear")==1)
    {
        //bring in the bear
        location lBear=GetLocation(GetWaypointByTag("wp_bear_spwn2"));
        CreateObject(OBJECT_TYPE_CREATURE,"db_bear",lBear);
        SetLocalInt(GetModule(),"super_bear",1);
    }
}
