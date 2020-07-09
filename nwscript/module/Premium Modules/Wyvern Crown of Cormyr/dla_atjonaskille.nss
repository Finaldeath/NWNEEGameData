// April 2006
// B W-Husey
// PC kills his brother with suitable alignment shifts
#include "cu_functions"

void main()
{
            object oPC = GetPCSpeaker();
            object oJonas = OBJECT_SELF;
            effect eDeath = EffectDamage(500,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_ENERGY);
            // Alignment functions
            AligXP("Null",oPC,"EVIL",250,10);
            ScoreAlign(oPC,10,0,0,0,0,1,3,10,10,10);            //Evil benefit
            //Kill Jonas
            SetPlotFlag(oJonas,FALSE);
            SetIsDestroyable(TRUE,FALSE,FALSE);
            SetLocalInt(oJonas, "nCanDie", 1); // Jonas can be killed
            ChangeToStandardFaction(oJonas,STANDARD_FACTION_HOSTILE);
            SetIsTemporaryEnemy(oPC, oJonas);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oJonas);
            AddJournalQuestEntry("QRing", 51, oPC);
}
