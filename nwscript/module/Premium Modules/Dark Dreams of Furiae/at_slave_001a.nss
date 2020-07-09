// Law and Evil shift

#include "ddf_util"

void main()
{
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_EVIL, ALIGNMENT_SLIGHT, TRUE);
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_LAWFUL, ALIGNMENT_SLIGHT, TRUE);
}
