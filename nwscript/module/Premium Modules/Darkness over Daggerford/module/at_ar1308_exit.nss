// at_ar1308_exit
// created by Luspr on 28th Feb 2006
// create the new liam's hold lula and delete any hangers around in the crypt
void main()
{
    object oPC = GetExitingObject();
    if(GetIsPC(oPC))
    {
        //sieronius is dead and lula lives (just about!)
        if(GetLocalInt(GetModule(), "lula_met") ==4 &&
           GetLocalInt(GetModule(), "sd_met_lula") ==1)
        {
            //create new lula in Mayor Wilsey's
            location lLulaLH=GetLocation(GetWaypointByTag("wp_create_lula_lh"));
            CreateObject(OBJECT_TYPE_CREATURE,"db_lula_lh",lLulaLH,FALSE);
            //make sure we only create one lula
            SetLocalInt(GetModule(),"lula_met",5);
            //tidy up any remaining Lula's just in case
            object oLula=GetObjectByTag("db_lula");
            if(GetIsObjectValid(oLula))
            {
                DestroyObject(oLula);
            }
        }
    }
}
