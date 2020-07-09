//::///////////////////////////////////////////////
//:: Name mhb_potscdflt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On HearBeat script for the module
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////

void VerifyTorch(object oPC);

void main()
{
    object oPC = GetFirstPC();
    object oSelf = OBJECT_SELF;
    object oPoly = GetObjectByTag("a1_poly");
    int iReputation;

    while (GetIsObjectValid(oPC) == TRUE)
    {
        iReputation = GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oPC);
        if (iReputation != 50)
            SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 50, oPC);

        iReputation = GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, oPC);
        if (iReputation != 100)
            SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 100, oPC);

        iReputation = GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oPC);
        if (iReputation != 0)
            SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 0, oPC);

        iReputation = GetStandardFactionReputation(STANDARD_FACTION_MERCHANT, oPC);
        if (iReputation != 0)
            SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 0, oPC);

        VerifyTorch(oPC);

        oPC = GetNextPC();
    }

    object oFollow = GetLocalObject(oSelf, "POLY_FOLLOW");
    int iFollow = GetLocalInt(oSelf, "POLY_FOLLOW_ON");
    effect eTeleport;

    if (iFollow == TRUE)
    {
        if (GetIsObjectValid(oFollow) == FALSE)
        {
            oFollow = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
                PLAYER_CHAR_IS_PC, oSelf);
            // Does GetNearestCreature work across areas? Just in case it
            // doesn't, let's do this...
            if(!GetIsObjectValid(oFollow))
            {
                oFollow = GetFirstPC();
            }

            SetLocalObject(oSelf, "POLY_FOLLOW", oFollow);
        }

        if (GetArea(oFollow) == GetArea(oPoly))
        {
            if (GetCurrentAction(oPoly) != ACTION_FOLLOW)
            {
                AssignCommand(oPoly, ActionForceFollowObject(oFollow, 3.0f));
            }
        }
        else
        {
            eTeleport = EffectDisappearAppear(GetLocation(oFollow));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTeleport, oPoly, 3.0f);
        }
    }

    return;
}

void ActivateTorch(object oPC)
{
    effect eTorch = EffectAreaOfEffect(AOE_PER_CUSTOM_AOE, "aen_a1_fearfire");

    eTorch = SupernaturalEffect(eTorch);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTorch, oPC);
}

void VerifyTorch(object oPC)
{
    object oItemR = OBJECT_INVALID;
    object oItemL = OBJECT_INVALID;
    effect eFire;
    int iNeedEffect = TRUE;

    oItemR = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    oItemL = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);

    // does the player have a torch equiped?
    if ((GetTag(oItemR) == "a1_torch") || (GetTag(oItemR) == "a1_torch_long")
      || (GetTag(oItemL) == "a1_torch") || (GetTag(oItemL) == "a1_torch_long"))
    {
        // search for a torch effect
        eFire = GetFirstEffect(oPC);
        while (GetIsEffectValid(eFire) == TRUE)
        {
            if ((GetEffectCreator(eFire) == oItemR)
              || (GetEffectCreator(eFire) == oItemL))
            {
                // The player doesn't need to have the effect re-aplied
                iNeedEffect = FALSE;
            }

            eFire = GetNextEffect(oPC);
        }

        // If the player needs the effect re-applied assign the apply to the
        if (iNeedEffect == TRUE)
        {
            if ((GetTag(oItemR) == "a1_torch") || (GetTag(oItemR) == "a1_torch_long"))
            {
                AssignCommand(oItemR, ActivateTorch(oPC));
            }
            else if ((GetTag(oItemL) == "a1_torch") || (GetTag(oItemL) == "a1_torch_long"))
            {
                AssignCommand(oItemL, ActivateTorch(oPC));
            }
            else if (((GetTag(oItemL) == "a1_torch") || (GetTag(oItemL) == "a1_torch_long"))
              && ((GetTag(oItemR) == "a1_torch") || (GetTag(oItemR) == "a1_torch_long")))
            {
                AssignCommand(oItemR, ActivateTorch(oPC));
                AssignCommand(oItemL, ActivateTorch(oPC));
            }
        }
    }
}
