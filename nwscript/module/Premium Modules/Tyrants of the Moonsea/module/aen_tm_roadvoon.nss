#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC) && !GetLocalInt(GetArea(oPC),"Madoc_talked"))
    {
        // fog color was set to black to get black borders around the movie
        // restore the intended fog color now
        SetFogColor(FOG_TYPE_SUN, FOG_COLOR_GREY, GetArea(oPC));

        // start the intro cutscene
        SetLocalInt(GetArea(oPC),"Madoc_talked",1);
        ExploreAreaForPlayer(GetArea(oPC), oPC, TRUE);
        CutscenePlay(oPC, "cut_tm_wagon");
    }
}
