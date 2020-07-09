//::///////////////////////////////////////////////
//::
//:: a3_bw_oh_sdoorm
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Heartbeat script for placeables.
//::
//:: Check for nearby PC or associate, check
//:: if they detect a secret door, and if so,
//:: create one with same tag as this object.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 9/20/2005
//::
//:://////////////////////////////////////////////

void main()
{
    int nDiscovered = GetLocalInt(OBJECT_SELF, "nDiscovered");
    if (nDiscovered == 1) return; // this secret door has been found

    // this variable sets the distance threshold for characters to notice the secret door
    float fRadius = 12.0;

    // this object's name should end in two digits, this is equal to the DC to notice the door
    string sDC = GetStringRight(GetName(OBJECT_SELF), 2);
    int nDC = StringToInt(sDC);

    // this is the blueprint to be created, type of secret found
    string sBP = "bw_sdoor";                                        // secret door is default
    if ((FindSubString(GetTag(OBJECT_SELF), "strap") != -1)) sBP = "bw_strap"; // trap door

    int nNth = 1;
    object oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, nNth);
    float fDist = GetDistanceToObject(oCreature);

    int nCheck;
    int nBonus;

    while (GetIsObjectValid(oCreature) && (fDist < fRadius) && (nDiscovered == 0))
    {
        // creature is nearby
        if (GetIsPC(oCreature) || (GetAssociateType(oCreature) != ASSOCIATE_TYPE_NONE))
        {
            // player or associate found
            if (GetDetectMode(oCreature) == DETECT_MODE_ACTIVE)
            {
                // actively searching
                nBonus = GetSkillRank(SKILL_SEARCH, oCreature);
                nCheck = d20() + nBonus;
                if (nCheck >= nDC)
                {
                    // found secret door
                    CreateObject(OBJECT_TYPE_PLACEABLE, sBP, GetLocation(OBJECT_SELF), FALSE, GetTag(OBJECT_SELF));

                    PlayVoiceChat(VOICE_CHAT_LOOKHERE, oCreature);

                    /*
                    if (GetIsPC(oCreature))
                    {
                        FloatingTextStringOnCreature("Something is hidden here!", oCreature, TRUE);
                    }
                    */

                    DestroyObject(OBJECT_SELF, 2.0f);

                    nDiscovered = 1;
                    SetLocalInt(OBJECT_SELF, "nDiscovered", nDiscovered);
                }

                /*
                // DEBUG
                if (GetIsPC(oCreature))
                {
                    SendMessageToPC(oCreature, ("DEBUG: Check: " + IntToString(nCheck) + " DC: " + IntToString(nDC) + " Bonus: " + IntToString(nBonus)));
                }
                // DEBUG
                */
            }
        }

        if (nDiscovered == 0)
        {
            nNth += 1;
            oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, nNth, CREATURE_TYPE_IS_ALIVE, TRUE);
            fDist = GetDistanceToObject(oCreature);
        }
    }
}
