// slim chance to generate random awesome loot on death
// .. most creatures create random loot on spawn; set X2_L_NOTREASURE on the
// .. creature to prevent double loot (not that it matters much at this point)

#include "nw_o2_coninclude"

void main()
{
    int nRand = d100();
    if (nRand >= 95)
    {
        object oKiller = GetLastKiller();
        GenerateTreasure(TREASURE_BOSS, oKiller, OBJECT_SELF);
    }
}
