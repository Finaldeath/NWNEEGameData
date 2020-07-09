//a3_talk_onopen
//This will start the placeables/doors conversation when open by the PC
//To be placed on the onopened event of a door/placeable
//
//Author: Phil Mitchell (Baron of Gateford)

void main()
{
    object oPC = GetLastOpenedBy();
    ActionStartConversation(oPC,"");
}
