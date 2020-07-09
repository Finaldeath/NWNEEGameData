// the player takes the mirrors from the sacks in illefarn

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    PlotLevelSet(GetTag(OBJECT_SELF), 2);
    int i;
    for (i=1; i<=5; i++)
    {
        CreateItemOnObject("bw_mirror", oPC);
    }
}
