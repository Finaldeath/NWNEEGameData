// returns false if the PC does not have the spell learned

#include "hf_in_spellcheck"

int StartingConditional()
{
    int nSpell = SPELL_FEAR;

    object oPC = GetPCSpeaker();

    return(SpellCanCast(oPC, nSpell));
}
