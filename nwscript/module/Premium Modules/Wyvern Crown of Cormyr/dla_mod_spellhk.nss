////////////////////////////////////////////////////////////////////////////////
// dla_mod_spellhk - Wyvern Crown of Cormyr  SPELL HOOK
// Original Scripter: Deva B. Winblood       6/15/2006
//------------------------------------------------------------------------------
// This spellhook is intended to prevent mounted targets from being targetted
// by polymorph and similar spells that would alter their appearance.
////////////////////////////////////////////////////////////////////////////////

#include "dla_i0_horse"
#include "x2_inc_spellhook"

//////////////////////
// PROTOTYPES
//////////////////////


// FILE: dla_mod_spellhk
// This function will return TRUE if the spell cast is one of those that
// is not allowed to be targeted at mounted targets.
int DLA_GetIsDisallowedSpell(int nSpellID);


/////////////////////////////////////////////////////////////////[ MAIN ]///////
void main()
{

    object oCaster=OBJECT_SELF;
    int nSpellID=GetSpellId();
    object oTarget=GetSpellTargetObject();

    //DLA_HorseDebug("Spellhook: "+GetName(oCaster)+" casts "+IntToString(nSpellID)+" at "+GetName(oTarget));

    if (DLA_GetIsMounted(oTarget)||(!GetIsObjectValid(oTarget)&&DLA_GetIsMounted(oCaster)))
    { // target is mounted

        //DLA_HorseDebug("     Spellhook Target is mounted.");

        if (DLA_GetIsDisallowedSpell(nSpellID))
        { // bad spell
            FloatingTextStringOnCreature("Shapeshifting spells may not be cast upon mounted targets.",oCaster,FALSE);
            SetModuleOverrideSpellScriptFinished();
        } // bad spell

    } // target is mounted

}
/////////////////////////////////////////////////////////////////[ MAIN ]///////

//////////////////////
// FUNCTIONS
//////////////////////

int DLA_GetIsDisallowedSpell(int nSpellID)
{ // PURPOSE: To return TRUE if nSpellID is a bad spell to cast on mounted targets

    switch(nSpellID)
    { // check
        case SPELL_POLYMORPH_SELF:
        case SPELL_SHAPECHANGE:
        case SPELL_TENSERS_TRANSFORMATION:
        case 387:
        case 388:
        case 389:
        case 390:
        case 391:
        case 392:
        case 393:
        case 394:
        case 395:
        case 396:
        case 397:
        case 398:
        case 399:
        case 400:
        case 401:
        case 402:
        case 403:
        case 404:
        case 405:
        case 670:
        case 671:
        case 672:
        case 673:
        case 674:
        case 675:
        case 676:
        case 677:
        case 678:
        case 679:
        case 680:
        case 681:
        case 682:
        case 683:
        case 684:
        case 685:
        case 691:
        case 692:
        case 693:
        case 694:
        case 704:
        case 705:
        case 706:
        case 707:
        case 708:
        case 709:
        case 732:
        case 733:
        case 734:
        case 735:
        case 737:
        case 738:
        case 739:
        case 740:
        { // not allowed
            return TRUE;
            break;
        } // not allowed
        default: break;
    } // check


    return FALSE;

} // DLA_GetIsDisallowedSpell()
