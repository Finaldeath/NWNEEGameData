//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: dtc_tm_zhentrn_c
//:: DATE: January 15, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Zhentil Keep Ruins - Door Transition
//::
//:: The door will start a conversation with the player
//::////////////////////////////////////////////////////

void main()
{
    object oPC = GetClickingObject();

    if (GetIsPC(oPC))
    {
        AssignCommand(oPC, ClearAllActions(TRUE));
        ActionStartConversation(oPC, "tm_zhentrn_door0", FALSE, FALSE);
    }
}
