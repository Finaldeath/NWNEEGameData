// modify the worldmap destination based on the game plot
// required for the side-quests described in the "Encounters" document
// also force the player to use a seaport to cross the moonsea because
// 1) we don't want horses to sneak across the sea
// 2) there are important plot triggers that happen on the sea

//
// INPUT:
// - sWM_DESTINATION_OVERRIDE_FROM
// - sWM_DESTINATION_OVERRIDE_TO
//
// OUPUT:
// - sWM_DESTINATION_OVERRIDE_RESULT
// - sWM_DESTINATION_OVERRIDE_DAYS
// - sWM_DESTINATION_OVERRIDE_HOURS

#include "hf_in_worldmap"
#include "hf_in_plot"
#include "hf_in_npc"
#include "hf_in_horse"

// returns true if the given area is on the north side of the moonsea
int IsNorthernArea(string sArea)
{
    if (sArea == "ThentiaE" || sArea == "MelvauntSY" || sArea == "ZhentilOC" ||
        sArea == "TharScar" || sArea == "TharKurSMG" || sArea == "TharIyrath" ||
        sArea == "TharRA")
    {
        return TRUE;
    }
    return FALSE;
}

// returns true if the given area is on the south side of the moonsea
int IsSouthernArea(string sArea)
{
    return !IsNorthernArea(sArea);
}

// the player will instead travel to this new place
// note that the destination tag is a from a waypoint (not an area name)
void OverrideDestination(string sTag, int nDays, int nHours)
{
    SetLocalString(OBJECT_SELF,sWM_DESTINATION_OVERRIDE_RESULT, sTag);
    SetLocalInt(OBJECT_SELF, sWM_DESTINATION_OVERRIDE_DAYS, nDays);
    SetLocalInt(OBJECT_SELF, sWM_DESTINATION_OVERRIDE_HOURS, nHours);
}

void main()
{
    string sPrevArea = GetLocalString(OBJECT_SELF, sWM_DESTINATION_OVERRIDE_FROM);
    string sDestArea = GetLocalString(OBJECT_SELF, sWM_DESTINATION_OVERRIDE_TO);
    object oPC = GetFirstPC();
    int nShipTravel = GetLocalInt(oPC, "nWM_ShipTravel");

    // reset global faction reputations; this is done for general robustness
    // under the assumption that the player has left the area for a while
    // so all transgressions are forgiven or forgotten
    ResetFactionReputation(oPC, oPC);
    object oIndependentFactionMember = GetObjectByTag("hf_faction_independent");
    if (GetIsObjectValid(oIndependentFactionMember))
    {
        int nRep = GetFactionAverageReputation(oIndependentFactionMember, oPC);
        if (nRep != 50)
            AdjustFactionReputation(oPC, oIndependentFactionMember, (50-nRep));
    }

    // Sea crossings must stop in a sea port (North -> South)
    if (nShipTravel <= 0)
    {
        if (IsNorthernArea(sPrevArea) && IsSouthernArea(sDestArea))
        {
            SetLocalInt(oPC, "HF_MAP_ROUTE_BLOCKED", 1);
            OverrideDestination("WP_TH_SHIP_ENTER", 0, 4);
            return;
        }
    }

    // Sea crossings must stop in a sea port (South -> North)
    if (nShipTravel <= 0)
    {
        if (IsSouthernArea(sPrevArea) && IsNorthernArea(sDestArea))
        {
            SetLocalInt(oPC, "HF_MAP_ROUTE_BLOCKED", 1);
            OverrideDestination("WP_EL_SHIP_ENTER", 0, 4);
            return;
        }
    }

    // Mulmaster is on the south-side but only accessible by sea
    if (nShipTravel <= 0)
    {
        if (IsSouthernArea(sPrevArea) && sDestArea == "MulmasterD")
        {
            SetLocalInt(oPC, "HF_MAP_ROUTE_BLOCKED", 1);
            OverrideDestination("WP_EL_SHIP_ENTER", 0, 4);
            return;
        }
    }

    // ZK and ML are on the north-side but only accessible by sea
    if (nShipTravel <= 0)
    {
        if (IsNorthernArea(sPrevArea) && (sDestArea == "ZhentilOC" || sDestArea == "MelvauntSY"))
        {
            SetLocalInt(oPC, "HF_MAP_ROUTE_BLOCKED", 1);
            OverrideDestination("WP_TH_SHIP_ENTER", 0, 4);
            return;
        }
    }

    // Random Encounter:
    // The first time the PC clicks to transition to the
    // "Shind Road East: Nearing Hillsfar" area, they meet Artemis, an assassin
    // THIS HAPPENS UNTIL THE PLAYER DEFEATS ARTEMIS
    if (sDestArea == "ShindRdEHF")
    {
        if (PlotLevelGet("ArtemisEntreriEncountered") == 0)
        {
            OverrideDestination("WP_RA_SHIN_PLAYER", 0, 4);
            return;
        }
    }

    // Pirates of the Moonsea:
    // The first time the PC uses the world map to cross to the north side
    // of the Moonsea, they will be stopped by Melvaunt's navy
    if ((sDestArea == "MelvauntSY" || sDestArea == "ThentiaE" || sDestArea == "ZhentilOC") &&
        (sPrevArea == "Elmwood" || sPrevArea == "MulmasterD"))
    {
        if (PlotLevelGet("AdmiralMeldonder") == 0)
        {
            PlotLevelSet("AdmiralMeldonder", 1);
            OverrideDestination("WP_RA_NAVY_PLAYER", 0, 4);
            return;
        }
    }

    // Pirates of the Moonsea:
    // The first time the PC tries to transition to Zhentil Keep after
    // receiving this quest, they will be ambushed by Burak the Mongrel
    if (sDestArea == "ZhentilOC")
    {
        if (PlotLevelGet("AdmiralMeldonder") == 2 && PlotLevelGet("BuraktheMongrel") == 0)
        {
            PlotLevelSet("BuraktheMongrel", 1);
            OverrideDestination("WP_RA_BRAK_PLAYER", 0, 4);
            return;
        }
        // The Pirate King's Blockade:
        // If transitioning to Zhentil Keep after meeting Orcus in Kur-Tharsu,
        // transition to Naval Blockade until help received from Selfaril
        else
        if (PlotLevelGet("PirateBlockade") == 1)
        {
            OverrideDestination("WP_MOBL_START_PLAYER", 0, 4);
            return;
        }
        // If transitioning to Zhentil Keep after obtaining help from Selfaril
        // to break the Naval Blockade, transition to Naval Battle
        else
        if (PlotLevelGet("PirateBlockade") == 2)
        {
            OverrideDestination("WP_MOBT_START_PLAYER", 0, 4);
            return;
        }
        // If transitioning to Zhentil Keep after completing Naval Battle,
        // transition to version of Zhentil Keep that is under attack
        else
        if (PlotLevelGet("PirateBlockade") == 3)
        {
            OverrideDestination("WP_ZK2_START_PLAYER", 0, 4);
            return;
        }
    }

    // Muragh's Magnificent Machine:
    // Once the PC has received the quest "Muragh's Magnificent Machine,"
    // there is a 33% chance, whenever they transition to or from Melvaunt
    // via ship, of encountering a group of water elementals
    if (sDestArea == "MelvauntSY" || sPrevArea == "MelvauntSY")
    {
        if (PlotLevelGet("HighArtificerHlessen") == 2 && PlotLevelGet("ElderWaterElemental") == 0)
        {
            if (d100() <= 33)
            {
                PlotLevelSet("ElderWaterElemental", 1);
                OverrideDestination("WP_RA_ELDER_PLAYER", 0, 4);
                return;
            }
        }
    }

    // Random Encounter:
    // The first time PC transitions back to Elmwood via ship,
    // they are attacked by a group of marels (evil aquatic elves)
    if (sDestArea == "Elmwood" &&
       (sPrevArea == "MulmasterD" || sPrevArea == "ThentiaE" || sPrevArea == "MelvauntSY" || sPrevArea == "ZhentilOC"))
    {
        if (PlotLevelGet("SeaElfAttack") == 0)
        {
            PlotLevelSet("SeaElfAttack", 1);
            OverrideDestination("WP_RA_MARELS_PLAYER", 0, 2);
            return;
        }
    }

    // Random Encounter:
    // The first time PC transitions to Elventree from Hillsfar, they will
    // meet the ranger Craster
    if (sDestArea == "Elventree" && sPrevArea == "Hillsfar")
    {
        if (PlotLevelGet("Craster") == 0)
        {
            PlotLevelSet("Craster", 1);
            OverrideDestination("WP_RA_CRASTER_PLAYER", 0, 2);
            return;
        }
    }

    // Random Encounter:
    // Once the PC has defeated the Crippled Fang, whenever they transition
    // between Cormanthor and Elventree, they will encounter the half-dragon
    // Karandas in the same area they met Craster and his elven companions.
    // THIS HAPPENS UNTIL THE PLAYER DEFEATS KARANDAS AND GETS DOMINION
    if (sDestArea == "Elventree" && (sPrevArea == "CormanthGF" || sPrevArea == "CormanthOE"))
    {
        if (PlotLevelGet("TheCrippledFangDead") == 1 || PlotLevelGet("TheCrippledFangDead") == 2)
        {
            PlotLevelSet("TheCrippledFangDead", 2);
            OverrideDestination("WP_RA_CRASTER_PLAYER", 0, 2);
            return;
        }
    }

    // Random Encounter:
    // If you attempt to transition to the Scarred Lands without horses,
    // there is a 90% chance of a random encounter with marauding monsters.
    // there is a 100% of a random encounter if the dukes have not told you
    // about the scarred lands. There are three different random encounter areas.
    if (sDestArea == "TharScar" && sPrevArea != "TharScar" && sPrevArea != "TharIyrath" && sPrevArea != "TharKurSMG")
    {
        int nEncounter = FALSE;
        if (!HorsePartyHasHorse(oPC))
        {
            if (d100() < 90)
            {
                nEncounter = TRUE;
            }
        }
        if (PlotLevelGet("DukesOfDaggerFordDone") <= 0)
        {
            nEncounter = TRUE;
        }
        if (nEncounter)
        {
            int nArea = d3();
            OverrideDestination("WP_RA_THAR_PLAYER_" + IntToString(nArea), 0, 1);
            return;
        }
    }
}
