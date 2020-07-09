void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC)&&GetLocalInt(GetModule(),"drop_off_exit")==1)
    {
        AssignCommand(oPC, SpeakString("After following a rough stone staircase for a few minutes you emerge on the cliff tops."));
        SetLocalInt(GetModule(),"drop_off_exit",2);
    }
}
