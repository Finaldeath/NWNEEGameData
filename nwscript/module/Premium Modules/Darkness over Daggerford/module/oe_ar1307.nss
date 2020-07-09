void main()
{
    if(GetLocalInt(GetModule(),"rab_plot")>=25
    &&GetLocalInt(GetModule(),"ar1307_setup")!=1)
    {
        SetLocalInt(GetModule(),"ar1307_setup",1);
        object oXanda=GetObjectByTag("db_xanda_living");
        DestroyObject(oXanda);
        location lDiary=GetLocation(GetWaypointByTag("wp_xanda_book"));
        //create object code
        CreateObject(OBJECT_TYPE_PLACEABLE,"db_xanda_book",lDiary);
    }
}
