//::///////////////////////////////////////////////
//:: Default: On Spell Cast At
//:: NW_C2_DEFAULTB
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This determines if the spell just cast at the
    target is harmful or not.

    GZ 2003-Oct-02 : - New AoE Behavior AI. Will use
                       Dispel Magic against AOES
                     - Flying Creatures will ignore
                       Grease

*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Dec 6, 2001
//:: Last Modified On: 2003-Oct-13
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Modified By: Deva Winblood
//:: Modified On: Jan 4th, 2008
//:: Added Support for Mounted Combat Feat Support
//:://////////////////////////////////////////////

#include "nw_i0_generic"
#include "x2_i0_spells"

void main()
{
   SpeakString("My spirit is trapped here for eternity. Your weak magic will not free me!");
   return;

}
