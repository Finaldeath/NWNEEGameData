//start making weapons
void main()
{
    object oPC=GetExitingObject();
    if(GetIsPC(oPC))
    {
        object oDerval = GetObjectByTag("db_dervil");
        SetLocalInt(oDerval,"working",0);
    }
}
