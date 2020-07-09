// Secondary door unlock script to avoid the player being stuck on the ship
// The marel ondeath script ndt_tm_marel should be one unlocking the door

#include "hf_in_plot"


const string LVAR_MAREL_CURRENT_WAVE = "re_marel_wave_cnt";
const int MAX_ATTACK_WAVES = 3;


void main()
{
    object oPC = GetClickingObject();

    if (GetIsPC(oPC))
    {
        // Check if the ancouner is over and unlock the door (in case it hasn't been done by the marel death script)
        if (GetLocked(OBJECT_SELF))
        {
            int nCurrentWave = PlotLevelGet(LVAR_MAREL_CURRENT_WAVE);
            if (nCurrentWave >= MAX_ATTACK_WAVES)
            {
                // Check if there are any living enemies left
                object oArea = GetArea(OBJECT_SELF);
                object oEnemy = GetFirstObjectInArea(oArea);
                int nEnemyCount = 0;
                while (GetIsObjectValid(oEnemy))
                {
                    if (GetIsReactionTypeHostile(oEnemy, oPC))
                        nEnemyCount++;

                    oEnemy = GetNextObjectInArea(oArea);
                }

                // Unlock door when no enemies are left, otherwise send a message
                if (nEnemyCount <= 0)
                {
                    SetLocked(OBJECT_SELF, FALSE);
                }
                else
                {
                    SendMessageToPC(oPC, "There are still enemies around.");
                }
            }
            else
            {
                SendMessageToPC(oPC, "You cannot leave at this time.");
            }
        }
    }
}
