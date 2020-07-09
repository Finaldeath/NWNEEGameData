// loose 1 worldwine, good & chaos shift (towards?)
#include "ddf_util"
#include "nw_i0_plot"


void main()
{

    TakeNumItems(GetPCSpeaker(), "WorldwinePotion", 1);

    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_CHAOTIC, ALIGNMENT_SLIP, TRUE);
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_GOOD, ALIGNMENT_SLIP, TRUE);

}
