#include "ddf_util"

void main()
{
    SetLocalInt(GetModule(), "ddf_quill_002_payment", TRUE);

    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_NEUTRAL, ALIGNMENT_SLIP, TRUE);
}
