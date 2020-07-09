void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC)&&GetLocalInt(OBJECT_SELF,"done")!=1)
    {
        SetLocalInt(OBJECT_SELF,"done",1);
        AssignCommand(oPC,SpeakString("A wave of intense melancholy washes over you, leaving the hairs on your body on end. What is this place?"));
    }
}
