//on enter script: if it's night the PC has the option
//to stake out for orcs
//Author: Damian Brown (Luspr)
//Date: 28-Aug-2005
void main()
{
    object oPC = GetEnteringObject();
    if(!GetLocalInt(GetModule(),"orcs_in_the_fields")==1)//quest is active
    {
        if(GetIsPC(oPC)&&GetIsNight())//only triggered by PC when dark
        {
            AssignCommand(oPC, ClearAllActions());
            AssignCommand(oPC, ActionStartConversation(oPC, "db_orc_stake_out", FALSE, FALSE));
        }
    }
}
