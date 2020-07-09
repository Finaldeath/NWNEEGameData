
#include "hf_in_worldmap"

void main()
{
    // initialize map
    // this should occur on module load
    if (GetLocalInt(GetModule(), "nWM_Initialized") == 0)
    {
        InitializeWorldMap();
        SetLocalInt(GetModule(), "nWM_Initialized", 1);
    }

    // function call to update world map area
    // this will create several placeables
    // it should be done sometime
    // prior to reaching world map area, not necessarily now...
    UpdateWorldMap();

    // run the standard BioWare module load event
    ExecuteScript("x2_mod_def_load", OBJECT_SELF);
}
