#include"inc_bw_worldmap"
void main()
{
    //astriel reveals the location of the trollbark lair
    RevealMapLocation("c1ar2200");
    //think BW may need an integer? so will set one in case
    SetLocalInt(GetModule(), "astriel_has_revealed", 1);
}
