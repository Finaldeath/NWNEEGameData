//Automatically fail a spell check

#include "hf_in_spellcheck"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oNPC = OBJECT_SELF;

    int nSpell = SpellGetSpellNum(oNPC);

    SpellCheckFail(oPC, oNPC, nSpell);

    return(TRUE);
}
