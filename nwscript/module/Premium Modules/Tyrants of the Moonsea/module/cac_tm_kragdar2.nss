//Kragdar attacks and ogre allies spawn

#include "hf_in_npc"
#include "hf_in_spawn"

void main()
{
    SpawnEnter(OBJECT_SELF);
    GoHostile(OBJECT_SELF);
}
