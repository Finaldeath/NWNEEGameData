#include "NW_I0_GENERIC"

void main()
{
    switch(GetUserDefinedEventNumber())
    {
        case 5100:
            int h = 1;
            object oDragon = OBJECT_SELF;
            object oPC = GetFirstPC();

            if((GetLocalInt(OBJECT_SELF, "nSurrendered") == 0) &&
               (GetLocalInt(OBJECT_SELF, "nStolenFrom") == 0) &&
               (!GetIsInCombat(oDragon)))
            {
                SetLocalInt(OBJECT_SELF, "nStolenFrom", 1);
                SetFacingPoint(GetPosition(oPC));
                SpeakString("Thief! How dare you try to steal my treasure!");
                ChangeToStandardFaction(oDragon,STANDARD_FACTION_HOSTILE);
                SetIsTemporaryEnemy(oPC, oDragon);
                DetermineCombatRound(oPC);
                object oHench = GetHenchman(oPC, h);

                while(oHench != OBJECT_INVALID)
                {
                    AssignCommand(oHench,DetermineCombatRound(oDragon));
                    h++;
                    oHench = GetHenchman(oPC, h);
                }
            }
            break;
        }
}
