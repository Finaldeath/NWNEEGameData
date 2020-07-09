//Luspr did this one on 31st July 2006

void main()
{

    object oPC = GetExitingObject();
    if (GetIsPC(oPC))
    {
    //on exit script for the holdfast inn upper floor with Drelia and Co.
    //check to see if the harpers have been killed if they turned hostile
    object oDrelia = GetObjectByTag("db_drelia");
    object oBrenda = GetObjectByTag("db_brenda");
    object oMeyhew = GetObjectByTag("db_meyhew");

    if(GetLocalInt(GetModule(), "harpers_attacked") ==1)
    //the harpers turned hostile
    {
        if(GetIsObjectValid(oDrelia) == FALSE &&
           GetIsObjectValid(oBrenda) == FALSE &&
           GetIsObjectValid(oMeyhew) == FALSE ||
           (GetIsDead(oDrelia) && GetIsDead(oBrenda) && GetIsDead(oMeyhew)))
           //all harpers were killed
           {
                SetLocalInt(GetModule(), "drelia_dead", 1);
                //flag for Astriel and Teygan convos
                SetLocalInt(GetModule(), "harpers_attacked", 2);
                //so we don't run this check over and over
           }
    }
    }
}
