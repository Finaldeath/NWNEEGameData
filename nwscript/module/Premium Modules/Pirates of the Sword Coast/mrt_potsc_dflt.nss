//::///////////////////////////////////////////////
//:: mrt_potsc_dflt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default resting rules for PotSC
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////

const string S_CAMPFIRE_OFF = "Without a fire, the island's predators will probably attack you as you sleep.";
const string S_CAMPFIRE_ON = "You rest easily as the fire wards off the night's unwanted visitors.";
const string S_UNDEAD_REST = "Sleep does not heal the ills of the restless dead.";

void main()
{
    object oPC = GetLastPCRested();
    object oModule = GetModule();
    object oArea, oCamp, oPoly;
    int iRestType = GetLastRestEventType();
    int iFire = 0;
    string sSubrace = GetSubRace(oPC);
    string sNPCTag1, sNPCTag2, sNPCTag3, sNPCTag4, sNPCTag5;
    int iStartHP;
    int iFinishedHP;
    int iReDamage;
    effect eReDamage;

    if (GetIsPC(oPC) == TRUE)
    {
        switch (iRestType)
        {
            //Rest started...
            case REST_EVENTTYPE_REST_STARTED:
            {
                //Get their starting HP and save it out for future reference
                iStartHP = GetCurrentHitPoints(oPC);
                SetLocalInt(oPC, "iRestHP_Start", iStartHP);

                //if a player rests, refresh polys song list.
                oPoly = GetObjectByTag("a1_poly");
                ForceRest(oPoly);

                // players cannot rest at campsites without a active fire.
                oArea = GetArea(oPC);
                if ((GetTag(oArea) == "JungleAbandon")
                  || (GetTag(oArea) == "SpindriftAbandonedCave")
                  || (GetTag(oArea) == "a1_darkcave"))
                {
                    oCamp = GetNearestObjectByTag("a1_dcavepit", oPC);
                    iFire = GetLocalInt(oCamp, "iFIREHEIGHT");

                    //15-20 high, 5-15 med, 1-5 low, 0 off
                    if (iFire > 0)
                    {
                        FloatingTextStringOnCreature(S_CAMPFIRE_ON, oPC, TRUE);
                    }
                    else
                    {
                        AssignCommand(oPC, ClearAllActions(TRUE));
                        FloatingTextStringOnCreature(S_CAMPFIRE_OFF, oPC, TRUE);
                    }
                }

                // If the player is on the island of the dead force rest the
                // NPC crewmen that follow the PC.
                if (GetTag(oArea) == "TheSeaofSwordsIslandoftheDead")
                {
                    sNPCTag1 = GetLocalString(oModule, "NPC_CREW1");
                    ForceRest(GetObjectByTag(sNPCTag1));
                    sNPCTag2 = GetLocalString(oModule, "NPC_CREW2");
                    ForceRest(GetObjectByTag(sNPCTag2));
                    sNPCTag3 = GetLocalString(oModule, "NPC_CREW3");
                    ForceRest(GetObjectByTag(sNPCTag3));
                    sNPCTag4 = GetLocalString(oModule, "NPC_CREW4");
                    ForceRest(GetObjectByTag(sNPCTag4));
                    sNPCTag5 = GetLocalString(oModule, "NPC_CREW5");
                    ForceRest(GetObjectByTag(sNPCTag5));
                }
            }
            break;
            //Rest cancelled...
            case REST_EVENTTYPE_REST_CANCELLED:
            {
            }
            break;
            //Rest completed...
            case REST_EVENTTYPE_REST_FINISHED:
            {
                //Negate any healing received by Undead players
                if (GetLocalInt(oPC, "IOP_CUST_UNDEAD") == TRUE)
                {
                    iStartHP = GetLocalInt(oPC, "iRestHP_Start");
                    iFinishedHP = GetCurrentHitPoints(oPC);
                    iReDamage = iFinishedHP - iStartHP;

                    //Send error message
                    FloatingTextStringOnCreature(S_UNDEAD_REST, oPC, TRUE);

                    //Ignore wacky situations where the player has fewer hitpoints than they started with
                    if (iReDamage > 0)
                    {
                        eReDamage = EffectDamage(iReDamage);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eReDamage, oPC);
                    }
                }
            }
            break;
            //Rest Invalid... somehow...
            case REST_EVENTTYPE_REST_INVALID:
            break;
        }
    }
}
