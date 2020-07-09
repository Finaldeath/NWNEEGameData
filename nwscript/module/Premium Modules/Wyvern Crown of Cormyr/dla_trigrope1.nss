// June 2003
// B W-Husey
// Offers PC the option to use a rope.
//#include "nw_i0_tool"
#include "cu_functions"
void main()
{
if(GetIsDefPC(GetEnteringObject()) && HasItem(GetEnteringObject(), "Rope")){
BeginConversation ("rope1",GetEnteringObject());}
else if (HasItem(GetEnteringObject(), "Rope")) //NPC conversation
BeginConversation ("ropenpc",GetEnteringObject());}
