// player has given all three pirate bounties to dryden

#include "hf_in_plot"

int StartingConditional()
{
    int nDone = PlotLevelGet("DrydenHeadsCompleted");
    return (nDone >= 3);
}
