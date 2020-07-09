void main()
{
    object oPC=GetEnteringObject();
    object oTrigger=GetObjectByTag("rab_conv");
    if(GetIsPC(oPC)&&!GetLocalInt(GetModule(),"rab_awake")==1)
    {
        //SetLocalInt(OBJECT_SELF,"fired",1);
        AssignCommand(oPC,ClearAllActions());
        AssignCommand(oTrigger,ActionStartConversation(oPC));
    }
}
