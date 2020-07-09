#include "cu_cameras"

void main()
{
    float fDirect = VectorToAngle(GetVectorAB(OBJECT_SELF,GetPCSpeaker()));
    fDirect = 360.0 - fDirect;
    SetFacing(fDirect);
}
