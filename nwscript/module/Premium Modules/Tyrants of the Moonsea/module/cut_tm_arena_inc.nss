//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//::////////////////////////////////////////////////////
//:: Stores ResRefs and Tags for the arena
//:: cutscenes
//::////////////////////////////////////////////////////


// Opponents
const string NPC_TAG_TANARUKK = "Tanarukk";
const string NPC_RESREF_TANARUKK = "tanarukk";
const string WP_TAG_TANARUKK_SPAWN = "WP_cut_arena_opponent_init0";
const string WP_TAG_TANARUKK_CENTER = "WP_cut_arena_opponent_center0";

const string NPC_TAG_DRIDER0 = "DriderSorcerer";
const string NPC_RESREF_DRIDER0 = "dridersorcerer";
const string WP_TAG_DRIDER0_SPAWN = "WP_cut_arena_opponent_init0";
const string WP_TAG_DRIDER0_CENTER = "WP_cut_arena_opponent_center0";

const string NPC_TAG_DRIDER1 = "DriderRogue1";
const string NPC_RESREF_DRIDER1 = "driderrogue";
const string WP_TAG_DRIDER1_SPAWN = "WP_cut_arena_opponent_init1";
const string WP_TAG_DRIDER1_CENTER = "WP_cut_arena_opponent_center1";

const string NPC_TAG_DRIDER2 = "DriderRogue2";
const string NPC_RESREF_DRIDER2 = "driderrogue001";
const string WP_TAG_DRIDER2_SPAWN = "WP_cut_arena_opponent_init2";
const string WP_TAG_DRIDER2_CENTER = "WP_cut_arena_opponent_center2";

const string NPC_RESREF_GOLEM = "magicgolem";
const string NPC_TAG_GOLEM = "MagicGolem";
const string WP_TAG_GOLEM_SPAWN = "WP_cut_arena_opponent_center1";

const string NPC_RESREF_MINOTAUR = "theredminotaur";
const string NPC_TAG_MINOTAUR = "TheRedMinotaur";
const string WP_TAG_MINOTAUR_SPAWN = "WP_cut_arena_opponent_center0";

const string NPC_RESREF_ONEHAND = "kaloronehand001";
const string NPC_TAG_ONEHAND = "PitKalorOnehand";
const string WP_TAG_ONEHAND_SPAWN = "WP_cut_arena_opponent_init0";
const string WP_TAG_ONEHAND_CENTER = "WP_cut_arena_opponent_center0";
const string WP_TAG_ONEHAND_DEFEATED = "WP_cut_arena_elf"; // Re-use Elfs Waypoint

const string NPC_RESREF_ONEHAND_DYING = "kaloronehand002";
const string NPC_TAG_ONEHAND_DYING = "DieKalorOnehand";
const string WP_TAG_ONEHAND_DYING = WP_TAG_ONEHAND_DEFEATED;


// Decorations
const string NPC_TAG_SPECTATOR1 = "hfarena_spectator1";
const string NPC_TAG_SPECTATOR2 = "hfarena_spectator2";
const string NPC_TAG_SPECTATOR3 = "hfarena_spectator3";
const string NPC_TAG_SPECTATOR4 = "hfarena_spectator4";

const string NPC_TAG_APPLETHROWER = "hfarena_applethrower";
const int SPELL_ID_APPLE_THROW = 15000;

const string NPC_RESREF_GUARD = "redplumemerce002";
const string NPC_TAG_GUARDx = "cre_cut_arena_guard"; // append number
const string WP_TAG_GUARDx_DESTINATION = "WP_cut_arena_guard"; // append number

const string NPC_RESREF_PLUMEOFF = "redplumeofficer";
const string WP_TAG_PLUMEOFF_SPAWN = "WP_hfcells_plumeoff_main";

// Announcer + Helpers
const string PLC_RESREF_ANNOUNCER_DUMMY = "tm_pl_dum_announ";
const string PLC_TAG_ANNOUNCER_DUMMY = "tm_pl_dum_announ";
const string PLC_TAG_ANNOUNCER_DUMMY_SPAWN = "WP_cut_arena_announcer_dummy";

const string NPC_TAG_ANNOUNCER = "Announcer";

// Player Waypoints
const string WP_TAG_PLAYER_INIT = "WP_cut_arena_pc_init";
const string WP_TAG_PLAYER_GATE = "WP_cut_arena_pc_gate";
const string WP_TAG_PLAYER_CENTER = "WP_cut_arena_pc_center";
const string WP_TAG_PLAYER_ASSOCIATES = "WP_cut_arena_pc_associates";
const string WP_TAG_PLAYER_TALK_ANNOUNCER = "WP_cut_arena_pc_talk_announcer";
const string WP_TAG_PLAYER_TALK_MAALTHIR = "WP_cut_arena_pc_talk_maalthir";
const string WP_TAG_PLAYER_CELLS = "WP_hfcells_pc_return";
const string WP_TAG_PLAYER_TEMPLE = "WP_TD_Jump";

// Plot NPCs
const string NPC_RESREF_BLIZZARD = "blizzard";
const string NPC_TAG_BLIZZARD = "Blizzard";
const string WP_TAG_BLIZZARD_INIT = "WP_cut_arena_blizzard";
const string WP_TAG_BLIZZARD_CELLS = "WP_hfcells_blizz_cell";
const string WP_TAG_BLIZZARD_OFFSCREEN = "WP_hfcells_blizz_offscreen";
const string WP_TAG_BLIZZARD_MELVAUNT = "WP_melv_breakw_blizzard";

const string NPC_RESREF_ELF = "elf";
const string NPC_TAG_ELF = "Elf";
const string WP_TAG_ELF_INIT = "WP_cut_arena_elf";
const string WP_TAG_ELF_CELLS = "WP_hfcells_elf_cell";
const string WP_TAG_ELF_OFFSCREEN = "WP_hfcells_elf_offscreen";
const string WP_TAG_ELF_MELVAUNT = "WP_melv_market_elf_captive";

const string NPC_RESREF_GARTH = "fathergarth";
const string NPC_TAG_GARTH = "FatherGarth";
const string WP_TAG_GARTH_INIT = "WP_cut_arena_garth";
const string WP_TAG_GARTH_CELLS = "WP_hfcells_garth_cell";
const string WP_TAG_GARTH_OFFSCREEN = "WP_hfcells_garth_offscreen";

const string NPC_RESREF_INNOVATOR = "theinnovatorofpa";
const string NPC_TAG_INNOVATOR = "TheInnovatorofPain";
const string WP_TAG_INNOVATOR_INIT = "WP_cut_arena_innovator_viewer";
const string WP_TAG_INNOVATOR_CELLS = "WP_hfcells_innovator_cell";
const string WP_TAG_INNOVATOR_TALK = "WP_cut_arena_innovator_talk";
const string WP_TAG_INNOVATOR_DUNGEONS = "WP_Innovator_Post";
const string WP_TAG_INNOVATOR_OFFSCREEN = "WP_hfcells_innovator_offscreen";

const string NPC_RESREF_MAALTHIR = "maalthiir";
const string NPC_TAG_MAALTHIR = "Maalthiir";
const string WP_TAG_MAALTHIR_INIT = "WP_cut_arena_maalthir_viewer";
const string WP_TAG_MAALTHIR_TALK = "WP_cut_arena_maalthir_talk";
const string WP_TAG_MAALTHIR_PALACE = "WP_hfcastle_maalthiir";

// Arena gates
const string DOOR_TAG_ARENA_MAIN= "dr_hfarena_gate_main";
const string DOOR_TAG_ARENA_PLAYER = "dr_hfarena_gate_player";
const string DOOR_TAG_ARENA_OPPONENT = "dr_hfarena_gate_opponent";

const string DOOR_TAG_CELL_INNER = "YourCellToArenaComplex1";
const string DOOR_TAG_CELL_OUTER = "ArenaComplex1ToYourCell";

const string WP_TAG_MAIN_GATE_A = "WP_cut_arena_main_gateA";
const string WP_TAG_MAIN_GATE_B = "WP_cut_arena_main_gateB";

// Sound objects
const string SND_TAG_CHEER = "snd_hfarena_cheer";
const string SND_TAG_TAUNT = "snd_hfarena_taunt";
const string SND_TAG_FANFARE = "snd_hfarena_fanfare";
