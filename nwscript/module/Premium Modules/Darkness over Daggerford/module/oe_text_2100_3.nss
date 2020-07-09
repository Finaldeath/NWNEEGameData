void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC)&&GetLocalInt(GetModule(),"pirates_have_fled")==1)
    {
        SetLocalInt(GetModule(),"pirates_have_fled",2);
        AssignCommand(oPC,SpeakString("The Barracuda and her crew have fled.  It is unlikely you will see them again."));
    }
}
