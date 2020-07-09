#include "inc_id1_utility"

void main()
{
    object oDungeon = GetCurrentDungeon();
    SetLocalInt(oDungeon, "bBossTeleporter", FALSE);
}
