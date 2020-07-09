//Switch on Battle Music when PC approaches bridge
#include "hf_in_plot"

void main()
{
    if(GetIsPC(GetEnteringObject()) && PlotLevelGet("KTGateDestroyed") == 0)
    {
        MusicBattlePlay(GetArea(OBJECT_SELF));
    }
}
