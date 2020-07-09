// B G P Hughes (B W-Huesy)
// August 2005
// The door to Hawklin Castle is locked until the PC has been told to go there by Hawklin.

void main()
{
//   BeginConversation("doornoopen3",GetClickingObject());
   ActionStartConversation(GetClickingObject(),"doornoopen3");
}
