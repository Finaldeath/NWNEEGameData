void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC)&&GetLocalInt(OBJECT_SELF,"done")!=1)
    {
        SetLocalInt(OBJECT_SELF,"done",1);
        AssignCommand(oPC,SpeakString("A voice speaks: 'We are truly sorry if this hurts you -- hurry!' "));
    }
}
