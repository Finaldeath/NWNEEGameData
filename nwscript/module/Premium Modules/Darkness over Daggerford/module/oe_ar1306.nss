void main()
{
    //xanda's missing if the player has seen the nightwatch reporting to Wilsey
    if(GetLocalInt(GetModule(),"rab_plot")==30
    &&GetLocalInt(GetModule(),"ar1306_setup")!=1)
    {
        SetLocalInt(GetModule(),"ar1306_setup",1);
        object oXanda=GetObjectByTag("db_xanda_living");
        DestroyObject(oXanda);
        location lDiary=GetLocation(GetWaypointByTag("wp_xanda_book"));
        //create object code
        CreateObject(OBJECT_TYPE_PLACEABLE,"db_xanda_book",lDiary);
    }

    //this was broken if the player just refuses to listen to Rab
    //fixed 22nd june 2006 by luspr (my mistake anyway!)
    if (GetLocalInt(OBJECT_SELF, "ar1306_end") != 1)
    {
        if  (GetLocalInt(GetModule(),"rab_plot") == 45 ||
             GetLocalInt(GetModule(),"rab_plot") == 50)
        {
            //commented out destroy xanda as it's handled from the crypt functions
            //object oXanda=GetObjectByTag("db_xanda_living");
            location lXanda=GetLocation(GetWaypointByTag("wp_xanda_home"));
            //we have to get rid of the original xanda because she has the wrong convo
            //this'll teach me not to comment code properly *grrr*
            //if(GetIsObjectValid(oXanda))
            //{
              //  DestroyObject(oXanda);
            //}
            //lets just create a new one this is getting too confusing :-p(
            CreateObject(OBJECT_TYPE_CREATURE, "db_xanda_end", lXanda);

            object oBook = GetObjectByTag("db_xanda_book");
            if(GetIsObjectValid(oBook))
            {
                DestroyObject(oBook);
            }
            SetLocalInt(OBJECT_SELF, "ar1306_end", 1);
        }
    }
}
