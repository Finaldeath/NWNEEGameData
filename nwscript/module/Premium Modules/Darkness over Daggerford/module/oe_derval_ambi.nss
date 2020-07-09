//stop making weapons
void main()
{
    object oPC=GetEnteringObject();
    if(GetIsPC(oPC))
    {
        object oDerval = GetObjectByTag("db_dervil");
        SetLocalInt(oDerval,"working",1);
        AssignCommand(oDerval,ClearAllActions(TRUE));
    }
}
