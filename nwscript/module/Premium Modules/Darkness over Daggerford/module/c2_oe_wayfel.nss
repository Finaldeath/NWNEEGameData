//stop making weapons
void main()
{
    object oPC=GetEnteringObject();
    if(GetIsPC(oPC))
    {
        object oDerval = GetObjectByTag("pm_wayfel");
        SetLocalInt(oDerval,"working",1);
        AssignCommand(oDerval,ClearAllActions(TRUE));
    }
}
