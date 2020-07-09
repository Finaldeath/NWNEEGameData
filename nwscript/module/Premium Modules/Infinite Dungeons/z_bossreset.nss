#include "inc_id1_utility"

void main()
{
    object oDungeon = GetCurrentDungeon();
    SetLocalInt(oDungeon, "bBossTeleporter", FALSE);
    SetLocalInt(oDungeon, "bBossActivated", FALSE);
    SetLocalInt(oDungeon, "nBossLevel", 0);
    SetLocalInt(oDungeon, "bBossDetect", FALSE);
    SetLocalInt(oDungeon, "bBossDead", FALSE);
}
