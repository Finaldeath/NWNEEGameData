//at_astriel_Conv
//This script will be placed on the actions taken slot of the last node in falias conversation
//it will force the PC to talk to Astriel, once the coversation with Falias has ended.
//
//Author: Phil Mitchell (Baron of Gateford)
//
void main()
{
    object oPC = GetPCSpeaker();
    object oNPC = GetObjectByTag("pm_astriel");
    AssignCommand(oPC, ClearAllActions(TRUE));
    DelayCommand(1.0,(AssignCommand(oNPC, ActionStartConversation(oPC))));
}
