void main()
{
    object oPC=GetLastPerceived();
    if(GetIsPC(oPC)&&!GetLocalInt(OBJECT_SELF,"perceived")==0)
    {
        FloatingTextStringOnCreature("The render does not appear to be hostile...",oPC);
        SetLocalInt(OBJECT_SELF,"perceived",1);
    }
}
