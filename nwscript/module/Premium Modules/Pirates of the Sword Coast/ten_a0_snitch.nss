//:://////////////////////////////////////////////
//:: ten_a0_snitch
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Snitch the sailor will interact start a
    conversation with the PC.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
void main()
{
    object oSnitch = GetObjectByTag("a0_halfsailor");
    object oEntering = GetEnteringObject();
    int iDoOnce = GetLocalInt(oSnitch, "ten_a0_snitch");

    if ((GetIsPC(oEntering) == TRUE) && (iDoOnce == FALSE))
    {
        SetLocalInt(oSnitch, "ten_a0_snitch", TRUE);
        AssignCommand(oSnitch, ActionStartConversation(oEntering));
    }
}
