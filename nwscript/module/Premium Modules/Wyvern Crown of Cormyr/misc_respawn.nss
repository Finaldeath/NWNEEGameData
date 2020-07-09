//::///////////////////////////////////////////////
//:: Wyvern Crown Respawn script
//:: B W-Husey, January 2006
//:://////////////////////////////////////////////
//:://////Based on original Bioware///////////////
//:: Created By:   Brent
//:: Created On:   November
//:://////////////////////////////////////////////

/* HOW IT DIFFERS
    PC respawns at the nearest Spawn point WP_PCRespawn, if there is one in the area
    Else respawns where they died. Note respawning only occurs if the PC has a companion
    Who is still alive and is not miles away. They will then talk to the PC.
    PCs only heal half their hit points
*/


#include "nw_i0_plot"
#include "cu_functions"

// * Applies an XP and GP penalty
// * to the player respawning
void ApplyPenalty(object oDead)
{
    int nXP = GetXP(oDead);
    int nPenalty = 25 * GetHitDice(oDead);
    int nHD = GetHitDice(oDead);
    // * You can not lose a level with this respawning
    int nMin = ((nHD * (nHD - 1)) / 2) * 1000;

    int nNewXP = nXP - nPenalty;
    if (nNewXP < nMin)
       nNewXP = nMin;
    SetXP(oDead, nNewXP);
    /*
    int nGoldToTake =    FloatToInt(0.10 * GetGold(oDead));
    // * a cap of 10 000gp taken from you
    if (nGoldToTake > 10000)
    {
        nGoldToTake = 10000;
    }
    AssignCommand(oDead, TakeGoldFromCreature(nGoldToTake, oDead, TRUE));
    DelayCommand(4.0, FloatingTextStrRefOnCreature(58299, oDead, FALSE));
    DelayCommand(4.8, FloatingTextStrRefOnCreature(58300, oDead, FALSE));
    */
}


//////////////////////////////////////////////////////////////////////////////


void main()
{
    object oRespawner = GetLastRespawnButtonPresser();
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oRespawner);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oRespawner)/2), oRespawner);


    RemoveEffects(oRespawner);
    //Respawn
    string sDestTag =  "WP_PCRespawn";
    string sArea = GetTag(GetArea(oRespawner));
    object oDest = GetNearestObjectByTag(sDestTag,oRespawner);//nearest spawn point
    object oHench = ReturnHenchman(oRespawner,1);
    object oHench2 = ReturnHenchman(oRespawner,2);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(10), oHench);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(10), oHench2);

    // check it's valid and in the same are:
    if (GetIsObjectValid(oDest) && GetArea(oDest)==GetArea(oRespawner))
    {
            location lSpawn = GetLocation(GetNearestObjectByTag(sDestTag));
            SetLocalLocation(oRespawner, "NW_L_I_DIED_HERE", GetLocation(GetLastRespawnButtonPresser()));
            SetLocalInt(oRespawner, "NW_L_I_DIED", 1);
            SetLocalObject(oDest, "NW_L_LASTDIED", GetLastRespawnButtonPresser());
            // Penalty if required after balancing
            ApplyPenalty(oRespawner);

        AssignCommand(oRespawner,GroupTransition(oRespawner,oDest));
        BeHappy(oRespawner);
        DelayCommand(0.1,AssignCommand(oRespawner,ClearAllActions(TRUE)));
        DelayCommand(0.2,AssignCommand(oHench,ClearAllActions(TRUE)));
        DelayCommand(0.2,AssignCommand(oHench2,ClearAllActions(TRUE)));
        DelayCommand(0.3,AssignCommand(oHench, DelayCommand(1.0,ActionStartConversation(oRespawner,"afterdeath"))));

        // * mak
    }
    else  //An area where respawn points don't matter
    {
            BeHappy(oRespawner);
            AssignCommand(oRespawner,ClearAllActions(TRUE));
            AssignCommand(oHench,ClearAllActions(TRUE));
            AssignCommand(oHench2,ClearAllActions(TRUE));
            AssignCommand(oHench, DelayCommand(1.0,ActionStartConversation(oRespawner,"afterdeath2")));
        // * do nothing, just 'res where you are.
    }
 }
