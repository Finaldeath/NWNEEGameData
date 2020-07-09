// Returns true if Aladara AND Harasi have been investigated

#include "ddf_util"

int StartingConditional()
{
    if (GetQuestState(AREA_NORTH_MARKET) != INVESTIGATION_COMPLETE) return FALSE;       // Aladara
    if (GetQuestState(AREA_SOUL_TRADE_INN) != INVESTIGATION_COMPLETE) return FALSE;     // Harasi
    //if (GetQuestState(AREA_ULANS_WAREHOUSE) != INVESTIGATION_COMPLETE) return FALSE;    // Ulan
    return TRUE;
}
