//Has Chesslyn told PC about Zhents Quarter?
#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("ChesslynZhents") == 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
