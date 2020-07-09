//::///////////////////////////////////////////////
//:: Tag constants
//:: inc_tagconstants.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Tag constants used by scripts in IoP.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: April 26, 2004
//:://////////////////////////////////////////////

// Examples are from Act 2. Use a0* for Act 0, a1* for Act 1, etc.

// Area tags
// example: const string a2a_Coastal_Island = "CoastalIsland";

// Waypoint tags
//example: const string a2w_TempleGuard1_WP1 = "temple_guard1_1";
const string a2w_Warehouse_Fighter1 = "WP_fighter1";
const string a2w_Warehouse_Fighter2 = "WP_fighter2";
const string a2w_Warehouse_Ring_Center = "WP_ring_center";
const string a2w_Warehouse_Redtip_Opponent_End = "cs_wp_fighter_end";
const string a2w_Warehouse_Redtip_Watch = "WP_Redtip_Watch";
const string a2w_Warehouse_Player_Watch = "WP_Player_Watch";
const string a2w_Warehouse_Hench1_Watch = "WP_Hench1_Watch";
const string a2w_Warehouse_Hench2_Watch = "WP_Hench2_Watch";

const string a2w_Manor_PC_Jump_From_Parlor = "WP_PC_Jump_From_Parlor";
const string a2w_Manor_XPM_Executioner_1 = "cs_wp_executioner1";
const string a2w_Manor_XPM_Executioner_2 = "cs_wp_executioner2";
const string a2w_Manor_XPM_Governor_1 = "cs_wp_governor1";
const string a2w_Manor_XPM_Langer_1 = "cs_wp_langer1";
const string a2w_Manor_XPM_Langer_2 = "cs_wp_langer2";
const string a2w_Manor_XPM_Tattooist_1 = "cs_wp_tattooist1";
const string a2w_Manor_XPM_Tattooist_2 = "cs_wp_tattooist2";
const string a2w_Manor_XPM_Guard_1 = "cs_wp_guard1";
const string a2w_Manor_XPM_Guard_End = "cs_wp_guard_end";
const string a2w_Manor_XPM_Garm = "cs_wp_garm";
const string a2w_Manor_XPM_Nisar = "cs_wp_nisar";

const string a2w_BeneathTemple_Portal = "WP_a2_temple_portal";
const string a2w_BeneathTemple_Flee1 = "WP_a2_temple_flee1";
const string a2w_BeneathTemple_Flee2 = "WP_a2_temple_flee2";

const string a2w_Willigan_Town_Kicked_Out = "cs_wp_kicked_out";
const string a2w_Willigan_Success_CS_Start = "WP_a2_willy_cut_start";
const string a2w_Willigan_Chest_Garb = "WP_a2_willychest_garb";
const string a2w_Willigan_Chest_Cutlass = "WP_a2_willychest_cutlass";
const string a2w_Willigan_Chest_Boots = "WP_a2_willychest_boots";

const string a2w_Willigan_CS_Fanny_1 = "cs_wp_fanny_1";
const string a2w_Willigan_CS_FannySis1_1 = "cs_wp_fannysis1_1";
const string a2w_Willigan_CS_FannySis2_1 = "cs_wp_fannysis2_1";
const string a2w_Willigan_CS_Willigan_1 = "cs_wp_willigan_1";
const string a2w_Willigan_CS_PC1_1 = "cs_wp_pc1_1";
const string a2w_Willigan_CS_PC2_1 = "cs_wp_pc2_1";
const string a2w_Willigan_CS_PC3_1 = "cs_wp_pc3_1";
const string a2w_Willigan_CS_PC4_1 = "cs_wp_pc4_1";
const string a2w_Willigan_CS_Hench1_1 = "cs_wp_hench1_1";
const string a2w_Willigan_CS_Hench2_1 = "cs_wp_hench2_1";

// Creature templates
//example: const string a2c_tag_Umberlant_Acolyte = "UmberlantAcolyte";
//         const string a2c_res_Umberlant_Acolyte = "umberlantacolyte";
const string a1c_tag_Garm = "a1_hench_garm";
const string a2c_tag_Nisar = "a2_hench_nisar";
const string a1c_tag_Poly = "a1_poly";

const string a2c_tag_Redtip = "RedTip";
const string a2c_res_Redtip = "redtip";
const string a2c_tag_Redtip_Fighter = "a2_fighter";
const string a2c_res_Redtip_Fighter = "redtip_fighter";

const string a2c_tag_FC_Scurvy_Johnson = "a2_scurvy";
const string a2c_tag_FC_Gretchen = "a2_gretchen";
const string a2c_tag_FC_Hook = "a2_fighter";
const string a2c_tag_FC_Direwolf = "NW_DIREWOLF";
const string a2c_tag_FC_Panther = "NW_PANTHER";

const string a2c_tag_Executioner = "a2_executioner";
const string a2c_tag_Governor = "a2_mayor";
const string a2c_tag_Tattooist = "a2_tattooist";
const string a2c_tag_Langer1 = "a2_langer1";
const string a2c_tag_Langer2 = "a2_langer2";
const string a2c_res_Langer2 = "langer2";

const string a2c_tag_Tasina = "a2_tasina";
const string a2c_tag_Priestess = "a2_umbpriestess";
const string a2c_tag_Sahuagin_Cleric = "a2_sahaucleric";
const string a2c_tag_Sahuagin_Guard = "a2_sahauguard";

const string a2c_tag_Willigan = "a2_willigan";
const string a2c_res_Willigan = "a2_willigan";
const string a2c_tag_Fanny = "a2_fanny";
const string a2c_res_Fanny = "fanny";
const string a2c_tag_FannySis1 = "a2_fannysis1";
const string a2c_res_FannySis1 = "fanny001";
const string a2c_tag_FannySis2 = "a2_fannysis2";
const string a2c_res_FannySis2 = "fanny002";

// Item templates/tags
// example: const string a2i_tag_UmberlantRobePC = "UmberlantRobePC";

// These items have the same tag and resref, so I won't define them individually
const string a2i_Willigan_Garb = "a2_wwgarb";
const string a2i_Willigan_Cutlass = "a2_wwcutless";
const string a2i_Willigan_Boots = "a2_wwboots";
const string a2i_Willigan_Outfit_NoGarb_NoBoots = "a2_willy1";
const string a2i_Willigan_Outfit_NoGarb_Boots = "a2_willy2";
const string a2i_Willigan_Outfit_Garb_NoBoots = "a2_willy3";

// Placeable tags
// example: const string a2p_Temple_Well = "temple_well";
const string a2p_temple_portal_spawn = "a2_tem_portspawn";

const string a2p_Willigan_Chest = "a2_willychest";
const string a2p_Willigan_CS_Willy_Target = "cs_willy_target";
const string a2p_Willigan_CS_Fanny_Target = "cs_fanny_target";

const string a2p_MidnightRose_Front = "a2_midrose_front";
const string a2p_MidnightRose_Mid = "a2_midrose_mid";
const string a2p_MidnightRose_Back = "a2_midrose_back";


// Door tags
// example: const string a2d_Bilge_West = "BilgeOutWest";
const string a2d_Spindrift_Willigan = "a2_spindrift_will1";
const string a2d_Willigan_Spindrift = "a2_will1_spindrift";

// sounds
// example: const string a2s_Redtip_CS_Sound = "Redtip_CS_Sound";

// cutscene object tags
// if you want to denote something as being specific for a cutscene
// example: const string a2cs_CELLS_wp_guard1 = "cs_wp_guard1";

// trigger tags
const string a2t_temple_portal = "a2_trig_temple_portal";
