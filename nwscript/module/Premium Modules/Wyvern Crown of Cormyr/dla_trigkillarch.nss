// B W-Husey, October 2005
// Destroy the projectile trap simulating the archer in the fort.
// Also switch on the Careless Master sidequest
#include "cu_functions"
void main()
{
    object oPC = GetEnteringObject();
    if (GetIsDefPC(oPC))
    {
    DestroyObject(GetNearestObjectByTag("FortArrow"));
    DestroyObject(GetNearestObjectByTag("LeftTurret"));
    DestroyObject(GetNearestObjectByTag("RightTurret"));
    AllParty("nCareActive",oPC,1);
    DestroyObject(OBJECT_SELF,0.5);
    }
}
