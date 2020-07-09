//a3_talk_onclick
//This will start the doors/placeables conversation when clciked by the PC
//To be placed on the onfailedto open event of a door/placeable
//
//Author: Phil Mitchell (Baron of Gateford)

void main()
{
    object oPC = GetClickingObject();
    ActionStartConversation(oPC,"");
}
