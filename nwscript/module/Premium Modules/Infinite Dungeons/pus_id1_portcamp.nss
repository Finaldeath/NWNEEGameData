#include "inc_id1_score"
void main()
{
    DebugMessage("");

    // get the player
    object oPC = GetItemActivator();
    DebugMessage("Player for portable camp is " + GetPCIdentifier(oPC));

    // check to see if player is in combat
    if (GetIsInCombat(oPC) == FALSE)
    {
        DebugMessage("Player is not in combat.");

        // check to see if a monster can be seen within 10.0
        int nCount = 1;
        int bHostile = FALSE;
        object oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC, nCount);
        string sTag = GetTag(oCreature);
        float fDistance = GetDistanceBetween(oPC, oCreature);
        DebugMessage("Examining creature " + sTag + " at distance " + FloatToString(fDistance));
        int bLOS;
        if ((GetIsEnemy(oPC, oCreature) == TRUE) && (fDistance <= 10.0))
        {
            DebugMessage("  Creature is hostile.");
            bLOS = LineOfSightObject(oPC, oCreature);
            if (bLOS == TRUE)
            {
                DebugMessage("    Creature has line of sight.");
                bHostile = TRUE;
            }
        }
        if (bHostile == FALSE)
        {
            nCount++;
        }
        while ((bHostile == FALSE) && (oCreature != OBJECT_INVALID) && (fabs(fDistance) <= 10.0))
        {
            oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC, nCount);
            sTag = GetTag(oCreature);
            fDistance = GetDistanceBetween(oPC, oCreature);
            DebugMessage("Examining creature " + sTag + " at distance " + FloatToString(fDistance));
            if ((GetIsEnemy(oPC, oCreature) == TRUE) && (fDistance <= 10.0))
            {
                DebugMessage("  Creature is hostile.");
                bLOS = LineOfSightObject(oPC, oCreature);
                if (bLOS == TRUE)
                {
                    DebugMessage("    Creature has line of sight.");
                    bHostile = TRUE;
                }
            }
            if (bHostile == FALSE)
            {
                nCount++;
            }
        }

        if (bHostile == FALSE)
        {
            DebugMessage("Letting player rest.");

            // let player rest
            SetLocalInt(oPC, "bCanRest", TRUE);
            DelayCommand(0.5, SetLocalInt(oPC, "bCanRest", FALSE));
            DebugMessage("Clearing actions. Point 38.");
            AssignCommand(oPC, ClearAllActions());
            AssignCommand(oPC, ActionRest(TRUE));

            // rest henchmen
            int nCount = 1;
            object oHenchman = GetHenchman(oPC, nCount);
            while (oHenchman != OBJECT_INVALID)
            {
                SetLocalInt(oHenchman, "bCanRest", TRUE);
                DelayCommand(0.5, SetLocalInt(oHenchman, "bCanRest", FALSE));
                DebugMessage("Clearing actions. Point H38.");
                AssignCommand(oHenchman, ClearAllActions());
                AssignCommand(oHenchman, ActionRest(TRUE));

                nCount++;
                oHenchman = GetHenchman(oPC, nCount);
            }

            // destroy camp object
            DestroyObject(OBJECT_SELF);
        } else
        {
            DebugMessage("Not letting player rest.");

            AssignCommand(oPC, SpeakString("You cannot rest while enemies are nearby.", TALKVOLUME_WHISPER));
        }
    } else
    {
        DebugMessage("Player is in combat.");

        AssignCommand(oPC, SpeakString("I cannot use this item in combat.", TALKVOLUME_WHISPER));
    }
}
