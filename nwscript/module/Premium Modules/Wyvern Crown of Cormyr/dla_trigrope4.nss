// June 2003
// B W-Husey
// Offers PC the option to use a rope.
//#include "nw_i0_tool"
#include "cu_functions"
void main()
{
object oPC = GetEnteringObject();
if (GetLocalInt(oPC,"nLWRope2")>0)
    {
    if(GetIsDefPC(GetEnteringObject()))
    {
        BeginConversation ("rope4",GetEnteringObject());
    }
    }
}
