//If the previous trigger has revealed the boulder can be removed etc.
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC) && GetLocalInt(oPC,"nPFUSecFound")==1)
        BeginConversation ("secretpassage",oPC);
}
