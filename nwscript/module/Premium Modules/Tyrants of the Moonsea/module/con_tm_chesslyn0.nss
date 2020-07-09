//Has Chesslyn not yet told PC about Zhents Quarter?
#include "hf_in_plot"

int StartingConditional()
{
    if(PlotLevelGet("ChesslynZhents") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
