// June 2003
// B W-Husey
// Offers PC the option to use a rope.
//#include "nw_i0_tool"
#include "cu_functions"
void DelayConv(string sConv, object oPC)
{
    BeginConversation ("rope2",oPC);
}

void main()
{
object oPC = GetEnteringObject();
if (GetLocalInt(oPC,"nLWRope1")>0)
    {
    if(GetIsDefPC(GetEnteringObject()))
    {
        AssignCommand(oPC,ClearAllActions(TRUE));
        DelayCommand(0.1,DelayConv ("rope2",oPC));
    }
    }
//version for rope use if didn't come across by rope.
else if(GetIsDefPC(GetEnteringObject()) && HasItem(GetEnteringObject(), "Rope")){
BeginConversation ("rope2b",GetEnteringObject());}
else if (HasItem(GetEnteringObject(), "Rope")) //NPC conversation
BeginConversation ("ropenpc",GetEnteringObject());
}
