#include "ddf_util"
void main()
{
    debug("-- make ulan secret door useable.");

    object oDoor = GetObjectByTag("UlanSecretDoor");
    if(oDoor == OBJECT_INVALID) debug("-- unable to find secret door...");

    SetUseableFlag(oDoor, TRUE);
}
