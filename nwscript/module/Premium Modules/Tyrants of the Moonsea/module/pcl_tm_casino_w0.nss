//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: pcl_tm_casino_w0
//:: DATE: January 15, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Mulmaster Casino - Wheel of Fortune
//::
//:: After the player placed his bet (= closed the
//:: container) a dialog is initiated
//::////////////////////////////////////////////////////

void main()
{
    object oPC = GetLastClosedBy();

    ActionStartConversation(oPC, "tm_casino_wheel0", FALSE, FALSE);
}
