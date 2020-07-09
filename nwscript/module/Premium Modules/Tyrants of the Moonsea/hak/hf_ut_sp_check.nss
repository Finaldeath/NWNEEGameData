// determine success of a cast spell
// ... the spell must be setup in a previous script

#include "hf_in_spellcheck"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oNPC = OBJECT_SELF;

    int nSpell = SpellGetSpellNum(oNPC);

    return(SpellCheck(oPC, oNPC, nSpell));
}
