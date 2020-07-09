////////////////////////////////////////////////////////////////////////////////
// dla_tcs_bghughes
//
// DLA, Wyvern Crown of Cormyr
////////////////////////////////////////////////////////////////////////////////
/*
    Trigger OnEnter event script to start the Game Master (BGP Hughes)
    conversation with the player.
 */
////////////////////////////////////////////////////////////////////////////////
// Created By: Syrsnein
// Created On: 12 June 2006
////////////////////////////////////////////////////////////////////////////////
/*
 Change history

 */

void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC)) return;

    if (!GetCutsceneMode(oPC))
        SetCutsceneMode(oPC);
    FadeFromBlack(oPC);
    DelayCommand(2.0, AssignCommand(GetObjectByTag("BGP_HUGHES"), ActionStartConversation(oPC)));
}
