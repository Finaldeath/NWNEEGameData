#include "inc_id1_camp"

void main()
{
    object oCamp = GetLocalObject(OBJECT_SELF, "oWaypoint");

    SpawnEncampment(oCamp);

    DelayCommand(0.1, DestroyObject(OBJECT_SELF));
}
