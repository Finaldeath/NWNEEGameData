// Edgar faces PC - if mounted, dismounts so he doesn't take the horse.
#include "cu_cameras"
#include "dla_i0_horse"

void main()
{
    float fDirect = GetDirection(OBJECT_SELF,GetPCSpeaker());
    object oEdgar = GetNearestObjectByTag("Edgar");
    fDirect = 360.0 - fDirect;
    AssignCommand(oEdgar,SetFacing(fDirect));
    if (DLA_GetIsMounted(oEdgar))
        DLA_Dismount(oEdgar);
}
