//start making weapons
void main()
{
    object oPC=GetExitingObject();
    if(GetIsPC(oPC))
    {
        object oDerval = GetObjectByTag("pm_wayfel");
        SetLocalInt(oDerval,"working",0);
    }
}
