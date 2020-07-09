void main()
{
    object oPC=GetEnteringObject();

    if(GetIsPC(oPC) && GetLocalInt(GetModule(), "iCliffsEntered") == 0)
    {
        SetLocalInt(GetModule(), "iCliffsEntered", 1);
        if(GetLocalInt(GetModule(), "iDaxiongFled") == 1)
        {
            CreateObject(OBJECT_TYPE_CREATURE, "rb_daxiong",
                         GetLocation(GetWaypointByTag("WP_1308_DAXIONG")));
        }

        if(GetRacialType(oPC) == RACIAL_TYPE_ELF)
        {
            SetDroppableFlag(GetObjectByTag("db_weddingring"), TRUE);
        }
    }

    if(GetLocalInt(GetModule(),"lula_met")==3)
    {
        location lLula1=GetLocation(GetWaypointByTag("wp_create_lula"));
        if(GetIsPC(oPC)&&!GetLocalInt(GetModule(),"ar1308_lula")==1)
        {
            SetLocalInt(GetModule(),"ar1308_lula",1);
            AddJournalQuestEntry("j31",10,oPC);
            CreateObject(OBJECT_TYPE_CREATURE,"db_lula",lLula1,FALSE);
        }
    }
}
