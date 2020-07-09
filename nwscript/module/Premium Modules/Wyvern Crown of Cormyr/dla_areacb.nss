// March 2007
// Mirko
// Set initial pillar state so all pillars are down
// Modified B W-Husey to stop multiple firing

#include "cu_functions"
void main()
{

    object oPC = GetEnteringObject();
    int nOnce = GetLocalInt(OBJECT_SELF,"nFired");
    if (GetIsDefPC(oPC) && nOnce<1)
    {
    SetLocalString(GetModule(),"finalPillarState","0000");
    SetLocalInt(OBJECT_SELF,"nFired",1);
    }
}
