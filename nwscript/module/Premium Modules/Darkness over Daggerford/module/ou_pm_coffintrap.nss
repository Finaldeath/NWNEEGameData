/////////////////////////////////////////////////////////
// Part of the Telarthir Tomb encounter (C1AR1402)
// this script will open the coffins in telarthir tomb
// and create skeleton warriors at each coffin location
//
// This is to be placed in the mummy conversation
// and on the onopened event of the coffins.
// Author: Baron of Gateford
/////////////////////////////////////////////////////////
#include "NW_I0_GENERIC"
#include "nw_i0_plot"
void main()
{
    effect eEffect = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD, FALSE);
    string sCoffTag = "pm_telarcoffin_1";
    //pm_telarcoffin_1
    object oCoffin = GetNearestObjectByTag(sCoffTag,GetFirstPC());
    string sTemplate = "NW_SKELWARR01";
    string snewtag = "pm_skel_1";
    location oLoc = GetLocation(oCoffin);
    int nCount = 1;
    object oArea = GetArea(OBJECT_SELF);
    object oSarc = GetObjectByTag("pm_telarthcasket");

    if (GetLocalInt(oArea,"SkellSpawned") == 0)
    {
        while(oCoffin != OBJECT_INVALID)
        {
            ApplyEffectToObject (DURATION_TYPE_TEMPORARY, eEffect, oCoffin, 1.0);
            AssignCommand(oCoffin,PlayAnimation( ANIMATION_PLACEABLE_OPEN ));
            CreateObject(OBJECT_TYPE_CREATURE,sTemplate,oLoc,FALSE,snewtag);
            AssignCommand(GetObjectByTag(snewtag), DetermineCombatRound());
            nCount ++;
            snewtag = ("pm_skel_" + IntToString(nCount));
            sCoffTag = ("pm_telarcoffin_" + IntToString(nCount));
            oCoffin = GetObjectByTag(sCoffTag);
            oLoc = GetLocation(oCoffin);
        }
        if (oSarc != OBJECT_INVALID)
        {
            //oCoffin = GetObjectByTag("pm_telarthcasket");
            oLoc = GetLocation(oSarc);
            ApplyEffectToObject (DURATION_TYPE_TEMPORARY, eEffect, oSarc, 1.0);
            AssignCommand(oSarc,PlayAnimation( ANIMATION_PLACEABLE_OPEN ));
            object oWarrior = CreateObject(OBJECT_TYPE_CREATURE,"NW_MUMFIGHT",oLoc,FALSE);
            //AssignCommand(GetNearestObjectByTag("NW_MUMFIGHT",GetFirstPC()), DetermineCombatRound());
            AssignCommand(oWarrior, DetermineCombatRound());
            //ChangeToStandardFaction(oMummy, STANDARD_FACTION_HOSTILE);
            //AssignCommand(oMummy, DetermineCombatRound());
        }
    SetLocalInt(oArea,"SkellSpawned",1);
    }
}
