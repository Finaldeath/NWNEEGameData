//::///////////////////////////////////////////////
//:: c3_ar1700_exit
//::
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy, based on Kevin's script
//:: Created On: Feb. 25, 2006
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetClickingObject();
    if (GetIsPC(oPC))
    {
        AssignCommand(oPC, ActionStartConversation(oPC, "ac_ar1700_south", FALSE, FALSE));
    }
}
