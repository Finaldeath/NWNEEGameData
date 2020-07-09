const int DLA_DEBUG             = FALSE;
const int DLA_DEBUG_ALL         = TRUE;
const int DLA_DEBUG_MOD         = FALSE;
const int DLA_DEBUG_AREA        = FALSE;
const int DLA_DEBUG_AOE         = FALSE;
const int DLA_DEBUG_CREATURE    = TRUE;
const int DLA_DEBUG_DOOR        = FALSE;
const int DLA_DEBUG_ENCOUNTER   = FALSE;
const int DLA_DEBUG_ITEM        = FALSE;
const int DLA_DEBUG_PLACEABLE   = TRUE;
const int DLA_DEBUG_STORE       = FALSE;
const int DLA_DEBUG_TRIGGER     = TRUE;
const int DLA_DEBUG_WAYPOINT    = FALSE;
const int DLA_DEBUG_LOG         = TRUE;

void DLA_Debug(string sMsg, int bForce=FALSE)
{
    if (GetLocalInt(GetModule(),"bDebugOff")) return;
    if (!DLA_DEBUG && !bForce) return;
    if (!DLA_DEBUG_ALL)
    {
        int nObjectType = GetObjectType(OBJECT_SELF);
        switch (nObjectType)
        {
            case 0:
                if (!DLA_DEBUG_MOD && !DLA_DEBUG_AREA) return;
            case OBJECT_TYPE_AREA_OF_EFFECT:
                if (!DLA_DEBUG_AOE) return;
            case OBJECT_TYPE_CREATURE:
                if (!DLA_DEBUG_CREATURE) return;
            case OBJECT_TYPE_DOOR:
                if (!DLA_DEBUG_DOOR) return;
            case OBJECT_TYPE_ENCOUNTER:
                if (!DLA_DEBUG_ENCOUNTER) return;
            case OBJECT_TYPE_ITEM:
                if (!DLA_DEBUG_ITEM) return;
            case OBJECT_TYPE_PLACEABLE:
                if (!DLA_DEBUG_PLACEABLE) return;
            case OBJECT_TYPE_STORE:
                if (!DLA_DEBUG_STORE) return;
            case OBJECT_TYPE_TRIGGER:
                if (!DLA_DEBUG_TRIGGER) return;
            case OBJECT_TYPE_WAYPOINT:
                if (!DLA_DEBUG_WAYPOINT) return;
        }
    }
    SendMessageToPC(GetFirstPC(), sMsg);
    if (DLA_DEBUG_LOG) WriteTimestampedLogEntry(sMsg);
}
