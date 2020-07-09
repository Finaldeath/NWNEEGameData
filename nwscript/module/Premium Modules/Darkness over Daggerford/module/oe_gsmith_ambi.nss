//stop making weapons
void main()
{
    object oPC=GetEnteringObject();
    if(GetIsPC(oPC))
    {
        object oWorkItem = GetLocalObject(GetObjectByTag("bw_smith"), "oWorkItem");
        if (GetIsObjectValid(oWorkItem))
        {
            return;
        }
        else
        {
            object oDerval = GetObjectByTag("bw_smith");
            SetLocalInt(oDerval,"iWorking",1);
            AssignCommand(oDerval,ClearAllActions(TRUE));
        }
    }
}
