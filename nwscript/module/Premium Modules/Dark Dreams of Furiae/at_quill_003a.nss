//  (Quillian unhenches, player loses 10 gold, alignment shifts a little toward neutral on the good/evil axis and law/chaos axis)
#include "ddf_util"

void main()
{
    // Unhench Quill
    RemoveHenchperson(OBJECT_SELF);

    // -10 GP
    ExecuteScript("at_take_gold_10", OBJECT_SELF);

    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_NEUTRAL, ALIGNMENT_SLIP, TRUE);

}
