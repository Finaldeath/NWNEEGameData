void main()
{
    object oPC=GetEnteringObject();
    object oBrick = GetObjectByTag("loose_brick");
    if(GetIsPC(oPC)&&!GetLocalInt(GetModule(),"1308secret")==1)
    {
        AssignCommand(oBrick,ActionStartConversation(oPC,"db_loosebrick"));
    }
}
