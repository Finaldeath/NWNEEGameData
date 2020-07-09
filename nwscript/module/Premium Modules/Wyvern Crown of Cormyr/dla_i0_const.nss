/*
    DLA_I0_CONST.nss      fhghfg
*/

// * CONSTANT DECLARATIONS
// Syrsnein, 2 Feb 2006 - Added new constants for attack and defense postures
// gaoneng erick, May 11, 2006 - added new constants for nightmare's spell abilities,
//                               nightmare's vfx, and howler's quills
// Deva Winblood, May 13, 2006 - added Party Mount, Party Dismount, Assign Mount
//                               feat constants


//tail models
    const int DLA_HORSE_TAIL_AUTOMATIC       = -1;  // Choose automatically the tail model if able
    // Walnut Horse
    const int DLA_HORSE1_TAIL_BAREBACK       = 4;  // Bareback
    const int DLA_HORSE1_TAIL_SADDLE         = 5;  // Saddle
    const int DLA_HORSE1_TAIL_SADDLE_PACKS   = 6;  // Saddle + Packs
    const int DLA_HORSE1_TAIL_BARDING1       = 7;  // leather/cloth Barding
    const int DLA_HORSE1_TAIL_BARDING2       = 8;  // plate/scale Barding
    const int DLA_HORSE1_TAIL_BARDING3       = 9;  // chain/plate Barding
    const int DLA_HORSE1_TAIL_BARDING4       = 10; // cloth/leather Barding
    const int DLA_HORSE1_TAIL_BARDING5       = 11; // plate/cloth Barding
    const int DLA_HORSE1_TAIL_BARDING_PACKS1 = 12; // leather/cloth Barding/Packs
    const int DLA_HORSE1_TAIL_BARDING_PACKS2 = 13; // plate/scale Barding/Packs
    const int DLA_HORSE1_TAIL_BARDING_PACKS3 = 14; // chain/plate Barding/Packs
    const int DLA_HORSE1_TAIL_BARDING_PACKS4 = 15; // cloth/leather Barding/Packs
    const int DLA_HORSE1_TAIL_BARDING_PACKS5 = 16; // plate/cloth Barding/Packs
    // Gunpowder Horse
    const int DLA_HORSE2_TAIL_BAREBACK       = 17; // Bareback
    const int DLA_HORSE2_TAIL_SADDLE         = 18; // Saddle
    const int DLA_HORSE2_TAIL_SADDLE_PACKS   = 19; // Saddle + Packs
    const int DLA_HORSE2_TAIL_BARDING1       = 20; // leather/cloth Barding
    const int DLA_HORSE2_TAIL_BARDING2       = 21; // plate/scale Barding
    const int DLA_HORSE2_TAIL_BARDING3       = 22; // chain/plate Barding
    const int DLA_HORSE2_TAIL_BARDING4       = 23; // cloth/leather Barding
    const int DLA_HORSE2_TAIL_BARDING5       = 24; // plate/cloth Barding
    const int DLA_HORSE2_TAIL_BARDING_PACKS1 = 25; // leather/cloth Barding/Packs
    const int DLA_HORSE2_TAIL_BARDING_PACKS2 = 26; // plate/scale Barding/Packs
    const int DLA_HORSE2_TAIL_BARDING_PACKS3 = 27; // chain/plate Barding/Packs
    const int DLA_HORSE2_TAIL_BARDING_PACKS4 = 28; // cloth/leather Barding/Packs
    const int DLA_HORSE2_TAIL_BARDING_PACKS5 = 29; // plate/cloth Barding/Packs
    // Spotted Horse
    const int DLA_HORSE3_TAIL_BAREBACK       = 30; // Bareback
    const int DLA_HORSE3_TAIL_SADDLE         = 31; // Saddle
    const int DLA_HORSE3_TAIL_SADDLE_PACKS   = 32; // Saddle + Packs
    const int DLA_HORSE3_TAIL_BARDING1       = 33; // leather/cloth Barding
    const int DLA_HORSE3_TAIL_BARDING2       = 34; // plate/scale Barding
    const int DLA_HORSE3_TAIL_BARDING3       = 35; // chain/plate Barding
    const int DLA_HORSE3_TAIL_BARDING4       = 36; // cloth/leather Barding
    const int DLA_HORSE3_TAIL_BARDING5       = 37; // plate/cloth Barding
    const int DLA_HORSE3_TAIL_BARDING_PACKS1 = 38; // leather/cloth Barding/Packs
    const int DLA_HORSE3_TAIL_BARDING_PACKS2 = 39; // plate/scale Barding/Packs
    const int DLA_HORSE3_TAIL_BARDING_PACKS3 = 40; // chain/plate Barding/Packs
    const int DLA_HORSE3_TAIL_BARDING_PACKS4 = 41; // cloth/leather Barding/Packs
    const int DLA_HORSE3_TAIL_BARDING_PACKS5 = 42; // plate/cloth Barding/Packs
    // Nightmare Horse
    const int DLA_HORSE4_TAIL_BAREBACK       = 43; // Bareback
    const int DLA_HORSE4_TAIL_SADDLE         = 44; // Saddle
    const int DLA_HORSE4_TAIL_SADDLE_PACKS   = 45; // Saddle + Packs
    const int DLA_HORSE4_TAIL_BARDING1       = 46; // leather/cloth Barding
    const int DLA_HORSE4_TAIL_BARDING2       = 47; // plate/scale Barding
    const int DLA_HORSE4_TAIL_BARDING3       = 48; // chain/plate Barding
    const int DLA_HORSE4_TAIL_BARDING4       = 49; // cloth/leather Barding
    const int DLA_HORSE4_TAIL_BARDING5       = 50; // plate/cloth Barding
    const int DLA_HORSE4_TAIL_BARDING_PACKS1 = 51; // leather/cloth Barding/Packs
    const int DLA_HORSE4_TAIL_BARDING_PACKS2 = 52; // plate/scale Barding/Packs
    const int DLA_HORSE4_TAIL_BARDING_PACKS3 = 53; // chain/plate Barding/Packs
    const int DLA_HORSE4_TAIL_BARDING_PACKS4 = 54; // cloth/leather Barding/Packs
    const int DLA_HORSE4_TAIL_BARDING_PACKS5 = 55; // plate/cloth Barding/Packs

    const int DLA_HORSE5_TAIL_BARDING2       = 56; // Nightmare

    // double the constants, double the fun
    const int DLA_HORSEJ_TAIL_PURPLE         = 57; // Purple
    const int DLA_HORSEJ_TAIL_JOUST1         = 57;
    const int DLA_HORSEJ_TAIL_BLUEGOLD       = 58; // Blue and gold diamonds
    const int DLA_HORSEJ_TAIL_JOUST2         = 58;
    const int DLA_HORSEJ_TAIL_BLACKWHITE     = 59; // Black and white checker
    const int DLA_HORSEJ_TAIL_JOUST3         = 59;
    const int DLA_HORSEJ_TAIL_REDGOLD        = 60; // Red and gold checker
    const int DLA_HORSEJ_TAIL_JOUST4         = 60;
    const int DLA_HORSEJ_TAIL_REDBLACK       = 61; // Red and Black diagonals
    const int DLA_HORSEJ_TAIL_JOUST5         = 61;
    const int DLA_HORSEJ_TAIL_GREENYELLOW    = 62; // Green with yellow spots
    const int DLA_HORSEJ_TAIL_JOUST6         = 62;
    const int DLA_HORSEJ_TAIL_PINKBLUE       = 63; // PINK and blue chevrons
    const int DLA_HORSEJ_TAIL_JOUST7         = 63;
    const int DLA_HORSEJ_TAIL_REDBRICK       = 64; // Brick pattern
    const int DLA_HORSEJ_TAIL_JOUST8         = 64;
    const int DLA_HORSEJ_TAIL_BLACK          = 65; // Black with gold trim
    const int DLA_HORSEJ_TAIL_JOUST9         = 65;
    const int DLA_HORSEJ_TAIL_BLUEWHITE      = 66; // Cyan and white stripes
    const int DLA_HORSEJ_TAIL_JOUST10        = 66;
    const int DLA_HORSEJ_TAIL_WHITE          = 67; // White
    const int DLA_HORSEJ_TAIL_JOUST11        = 67;

    const int DLA_HORSE_TAIL_NULL_TAIL       = 68; // used to kickstart appearance updates
    const int DLA_HORSE_TAIL_OFFSET          = 65; // amount to add to tail to find duplicate entries to kickstart appearance updates

    //full creature appearance models
    // Walnut Horse
    const int DLA_HORSE1_APPEARANCE_BAREBACK       = 487; // Bareback
    const int DLA_HORSE1_APPEARANCE_SADDLE         = 488; // Saddle
    const int DLA_HORSE1_APPEARANCE_SADDLE_PACKS   = 489; // Saddle + Packs
    const int DLA_HORSE1_APPEARANCE_BARDING1       = 490; // leather/cloth Barding
    const int DLA_HORSE1_APPEARANCE_BARDING2       = 491; // plate/scale Barding
    const int DLA_HORSE1_APPEARANCE_BARDING3       = 492; // chain/plate Barding
    const int DLA_HORSE1_APPEARANCE_BARDING4       = 493; // cloth/leather Barding
    const int DLA_HORSE1_APPEARANCE_BARDING5       = 494; // plate/cloth Barding
    const int DLA_HORSE1_APPEARANCE_BARDING_PACKS1 = 495; // leather/cloth Barding/Packs
    const int DLA_HORSE1_APPEARANCE_BARDING_PACKS2 = 496; // plate/scale Barding/Packs
    const int DLA_HORSE1_APPEARANCE_BARDING_PACKS3 = 497; // chain/plate Barding/Packs
    const int DLA_HORSE1_APPEARANCE_BARDING_PACKS4 = 498; // cloth/leather Barding/Packs
    const int DLA_HORSE1_APPEARANCE_BARDING_PACKS5 = 499; // plate/cloth Barding/Packs
    // Gunpowder Horse
    const int DLA_HORSE2_APPEARANCE_BAREBACK       = 500; // Bareback
    const int DLA_HORSE2_APPEARANCE_SADDLE         = 501; // Saddle
    const int DLA_HORSE2_APPEARANCE_SADDLE_PACKS   = 502; // Saddle + Packs
    const int DLA_HORSE2_APPEARANCE_BARDING1       = 503; // leather/cloth Barding
    const int DLA_HORSE2_APPEARANCE_BARDING2       = 504; // plate/scale Barding
    const int DLA_HORSE2_APPEARANCE_BARDING3       = 505; // chain/plate Barding
    const int DLA_HORSE2_APPEARANCE_BARDING4       = 506; // cloth/leather Barding
    const int DLA_HORSE2_APPEARANCE_BARDING5       = 507; // plate/cloth Barding
    const int DLA_HORSE2_APPEARANCE_BARDING_PACKS1 = 508; // leather/cloth Barding/Packs
    const int DLA_HORSE2_APPEARANCE_BARDING_PACKS2 = 509; // plate/scale Barding/Packs
    const int DLA_HORSE2_APPEARANCE_BARDING_PACKS3 = 510; // chain/plate Barding/Packs
    const int DLA_HORSE2_APPEARANCE_BARDING_PACKS4 = 511; // cloth/leather Barding/Packs
    const int DLA_HORSE2_APPEARANCE_BARDING_PACKS5 = 512; // plate/cloth Barding/Packs
    // Spotted Horse
    const int DLA_HORSE3_APPEARANCE_BAREBACK       = 513; // Bareback
    const int DLA_HORSE3_APPEARANCE_SADDLE         = 514; // Saddle
    const int DLA_HORSE3_APPEARANCE_SADDLE_PACKS   = 515; // Saddle + Packs
    const int DLA_HORSE3_APPEARANCE_BARDING1       = 516; // leather/cloth Barding
    const int DLA_HORSE3_APPEARANCE_BARDING2       = 517; // plate/scale Barding
    const int DLA_HORSE3_APPEARANCE_BARDING3       = 518; // chain/plate Barding
    const int DLA_HORSE3_APPEARANCE_BARDING4       = 519; // cloth/leather Barding
    const int DLA_HORSE3_APPEARANCE_BARDING5       = 520; // plate/cloth Barding
    const int DLA_HORSE3_APPEARANCE_BARDING_PACKS1 = 521; // leather/cloth Barding/Packs
    const int DLA_HORSE3_APPEARANCE_BARDING_PACKS2 = 522; // plate/scale Barding/Packs
    const int DLA_HORSE3_APPEARANCE_BARDING_PACKS3 = 523; // chain/plate Barding/Packs
    const int DLA_HORSE3_APPEARANCE_BARDING_PACKS4 = 524; // cloth/leather Barding/Packs
    const int DLA_HORSE3_APPEARANCE_BARDING_PACKS5 = 525; // plate/cloth Barding/Packs
    // Nightmare Horse
    const int DLA_HORSE4_APPEARANCE_BAREBACK       = 526; // Bareback
    const int DLA_HORSE4_APPEARANCE_SADDLE         = 527; // Saddle
    const int DLA_HORSE4_APPEARANCE_SADDLE_PACKS   = 528; // Saddle + Packs
    const int DLA_HORSE4_APPEARANCE_BARDING1       = 529; // leather/cloth Barding
    const int DLA_HORSE4_APPEARANCE_BARDING2       = 530; // plate/scale Barding
    const int DLA_HORSE4_APPEARANCE_BARDING3       = 531; // chain/plate Barding
    const int DLA_HORSE4_APPEARANCE_BARDING4       = 532; // cloth/leather Barding
    const int DLA_HORSE4_APPEARANCE_BARDING5       = 533; // plate/cloth Barding
    const int DLA_HORSE4_APPEARANCE_BARDING_PACKS1 = 534; // leather/cloth Barding/Packs
    const int DLA_HORSE4_APPEARANCE_BARDING_PACKS2 = 535; // plate/scale Barding/Packs
    const int DLA_HORSE4_APPEARANCE_BARDING_PACKS3 = 536; // chain/plate Barding/Packs
    const int DLA_HORSE4_APPEARANCE_BARDING_PACKS4 = 537; // cloth/leather Barding/Packs
    const int DLA_HORSE4_APPEARANCE_BARDING_PACKS5 = 538; // plate/cloth Barding/Packs

    const int DLA_HORSE5_APPEARANCE_NIGHTMARE      = 539; // plate/cloth Barding/Packs

    const int DLA_HORSEJ_APPEARANCE_JOUST1         = 541; // plate/cloth Barding/Packs
    const int DLA_HORSEJ_APPEARANCE_JOUST2         = 542; // plate/cloth Barding/Packs
    const int DLA_HORSEJ_APPEARANCE_JOUST3         = 543; // plate/cloth Barding/Packs
    const int DLA_HORSEJ_APPEARANCE_JOUST4         = 544; // plate/cloth Barding/Packs
    const int DLA_HORSEJ_APPEARANCE_JOUST5         = 545; // plate/cloth Barding/Packs
    const int DLA_HORSEJ_APPEARANCE_JOUST6         = 546; // plate/cloth Barding/Packs
    const int DLA_HORSEJ_APPEARANCE_JOUST7         = 547; // plate/cloth Barding/Packs
    const int DLA_HORSEJ_APPEARANCE_JOUST8         = 548; // plate/cloth Barding/Packs
    const int DLA_HORSEJ_APPEARANCE_JOUST9         = 549; // plate/cloth Barding/Packs
    const int DLA_HORSEJ_APPEARANCE_JOUST10         = 550; // plate/cloth Barding/Packs
    const int DLA_HORSEJ_APPEARANCE_JOUST11         = 551; // plate/cloth Barding/Packs

//appearance models to be applied to the PC when riding
    const int DLA_HORSE_APPEARANCE_DWARF_MALE    = 460;
    const int DLA_HORSE_APPEARANCE_ELF_MALE      = 461;
    const int DLA_HORSE_APPEARANCE_GNOME_MALE    = 462;
    const int DLA_HORSE_APPEARANCE_HALFLING_MALE = 463;
    const int DLA_HORSE_APPEARANCE_HALF_ELF_MALE = 464;
    const int DLA_HORSE_APPEARANCE_HALF_ORC_MALE = 465;
    const int DLA_HORSE_APPEARANCE_HUMAN_MALE    = 466;

    const int DLA_HORSE_APPEARANCE_DWARF_FEMALE    = 343;
    const int DLA_HORSE_APPEARANCE_ELF_FEMALE      = 344;
    const int DLA_HORSE_APPEARANCE_GNOME_FEMALE    = 345;
    const int DLA_HORSE_APPEARANCE_HALFLING_FEMALE = 346;
    const int DLA_HORSE_APPEARANCE_HALF_ELF_FEMALE = 347;
    const int DLA_HORSE_APPEARANCE_HALF_ORC_FEMALE = 348;
    const int DLA_HORSE_APPEARANCE_HUMAN_FEMALE    = 349;

//phenotypes
    const int PHENOTYPE_DLA_MOUNTED_NORMAL  = 3; //'normal' custom riding pheno
    const int PHENOTYPE_DLA_MOUNTED_BIG     = 5; //'fat' custom riding pheno
    const int PHENOTYPE_DLA_JOUSTING_NORMAL = 6; //'normal' custom jousting pheno
    const int PHENOTYPE_DLA_JOUSTING_BIG    = 8; //'fat' custom jousting pheno


//barding types
    const int DLA_HORSE_BARDING_TYPE_NONE     = 0;
    const int DLA_HORSE_BARDING_TYPE_1        = 1;
    const int DLA_HORSE_BARDING_TYPE_2        = 2;
    const int DLA_HORSE_BARDING_TYPE_3        = 3;
    const int DLA_HORSE_BARDING_TYPE_4        = 4;
    const int DLA_HORSE_BARDING_TYPE_5        = 5;

//portraits
    const int PORTRAIT_DLA_WALNUT_BAREBACK     = 2006;
    const int PORTRAIT_DLA_WALNUT_NOBARDING    = 2007;
    const int PORTRAIT_DLA_WALNUT_BARDING      = 2008;

    const int PORTRAIT_DLA_GUNPOWDER_BAREBACK  = 2009;
    const int PORTRAIT_DLA_GUNPOWDER_NOBARDING = 2010;
    const int PORTRAIT_DLA_GUNPOWDER_BARDING   = 2011;

    const int PORTRAIT_DLA_SPOTTED_BAREBACK    = 2012;
    const int PORTRAIT_DLA_SPOTTED_NOBARDING   = 2013;
    const int PORTRAIT_DLA_SPOTTED_BARDING     = 2014;

    const int PORTRAIT_DLA_NIGHTMARE_BAREBACK  = 2015;
    const int PORTRAIT_DLA_NIGHTMARE_NOBARDING = 2016;
    const int PORTRAIT_DLA_NIGHTMARE_BARDING   = 2017;

//colors
    const int DLA_HORSE_COLOR_WALNUT    = 1;
    const int DLA_HORSE_COLOR_GUNPOWDER = 2;
    const int DLA_HORSE_COLOR_SPOTTED   = 3;
    const int DLA_HORSE_COLOR_NIGHTMARE = 4;

//feats
    const int FEAT_DLA_HORSE_MENU           = 1600;
    const int FEAT_DLA_HORSE_DISMOUNT       = 1601;
    const int FEAT_DLA_HORSE_MOUNT          = 1602;
    const int FEAT_DLA_HORSE_PARTY_MOUNT    = 1603;
    const int FEAT_DLA_HORSE_PARTY_DISMOUNT = 1604;
    const int FEAT_DLA_HORSE_ASSIGN_MOUNT   = 1605;
    const int FEAT_DLA_PALADIN_SUMMON_MOUNT = 1606;
    const int FEAT_DLA_MOUNTED_COMBAT       = 1079;
    const int FEAT_DLA_MOUNTED_ARCHERY      = 1080;

//IP Bonus Feat
    const int IP_CONST_FEAT_DLA_HORSE_MENU  = 40;

//skill
    const int SKILL_DLA_RIDE = 27;

//animations
    const int ANIMATION_DLA_LOOPING_MOUNT      = ANIMATION_LOOPING_CUSTOM1;
    const int ANIMATION_DLA_LOOPING_DISMOUNT   = ANIMATION_LOOPING_CUSTOM2;
    const int ANIMATION_DLA_LOOPING_JOUST_VIOLENT_FALL = ANIMATION_LOOPING_CUSTOM3;
    const int ANIMATION_DLA_LOOPING_JOUST_GLANCE = ANIMATION_LOOPING_CUSTOM4;
    const int ANIMATION_DLA_LOOPING_JOUST_FALL = ANIMATION_LOOPING_CUSTOM5;
    const int ANIMATION_DLA_LOOPING_JOUST_STAB = ANIMATION_LOOPING_CUSTOM10;
    const int ANIMATION_DLA_LOOPING_JOUST_HELMOFF = ANIMATION_LOOPING_CUSTOM4;

//footstep sounds
    const int FOOTSTEP_TYPE_DLA_HORSE = 30;

//toolset creature templates
    const int DLA_TEMPLATE_LIGHT_HORSE_1 = 11; //saddled
    const int DLA_TEMPLATE_LIGHT_HORSE_2 = 12; //saddled/gear
    const int DLA_TEMPLATE_LIGHT_HORSE_3 = 13; //bareback

    const int DLA_TEMPLATE_HEAVY_HORSE_1 = 21; //saddled
    const int DLA_TEMPLATE_HEAVY_HORSE_2 = 22; //saddled/gear
    const int DLA_TEMPLATE_HEAVY_HORSE_3 = 23; //bareback

    const int DLA_TEMPLATE_LIGHT_WARHORSE_1 = 31; //saddled
    const int DLA_TEMPLATE_LIGHT_WARHORSE_2 = 32; //saddled/gear
    const int DLA_TEMPLATE_LIGHT_WARHORSE_3 = 33; //barded
    const int DLA_TEMPLATE_LIGHT_WARHORSE_4 = 34; //barded/gear
    const int DLA_TEMPLATE_LIGHT_WARHORSE_5 = 35; //bareback

    const int DLA_TEMPLATE_HEAVY_WARHORSE_1 = 41; //saddled
    const int DLA_TEMPLATE_HEAVY_WARHORSE_2 = 42; //saddled/gear
    const int DLA_TEMPLATE_HEAVY_WARHORSE_3 = 43; //barded
    const int DLA_TEMPLATE_HEAVY_WARHORSE_4 = 44; //barded/gear
    const int DLA_TEMPLATE_HEAVY_WARHORSE_5 = 45; //bareback

//custom tokens
    const int DLA_CONVERSATION_CUSTOM_TOKEN1 = 3000;

////////////////////////////////////////////////////////////////////////////////
// Joust Constants
//

    const string DLA_VAR_JOUST_STATE    = "dla_joust_state";

    const string DLA_VAR_JOUST_OPPONENT = "dla_joust_opponent";

    const string DLA_VAR_JOUST_OPP_SET   = "dla_joust_opp_set";
    const string DLA_VAR_JOUST_HELMET    = "dla_joust_helmet";
    const string DLA_VAR_JOUST_ARMOR     = "dla_joust_armor";
    const string DLA_VAR_JOUST_SHIELD    = "dla_joust_shield";
    const string DLA_VAR_JOUST_LANCE     = "dla_joust_lance";

    const string DLA_VAR_JOUST_ROUND     = "dla_joust_round";
    const string DLA_VAR_JOUST_ON        = "dla_joust_on";
    const string DLA_VAR_JOUST_OPP_SCORE = "dla_joust_opp_score";
    const string DLA_VAR_JOUST_PC_SCORE  = "dla_joust_pc_score";

    const string DLA_VAR_JOUST_MATCHES   = "dla_joust_matches";
    const string DLA_VAR_JOUST_WINS      = "dla_joust_wins";
    const string DLA_VAR_JOUST_MATCH_SET = "dla_joust_match_set";

    const string DLA_VAR_JOUST_EQ        = "dla_joust_equip_";
    const string DLA_VAR_JOUST_COLORS    = "dla_joust_colors";
    const string DLA_VAR_JOUST_LANCE_COLOR = "dla_joust_lance_color";

    const string DLA_VAR_JOUST_OPP_NUM   = "dla_joust_opp_index";
    const string DLA_VAR_JOUST_OPP_RESREF= "dla_joust_opp_resref";
    const string DLA_VAR_JOUST_OPP_NAME  = "dla_joust_opp_name";
    const string DLA_VAR_JOUST_TRAINING  = "dla_joust_training";

    const string DLA_VAR_JOUST_RETURN    = "dla_var_joust_return";

//jousting postures
// attack
    const int DLA_JOUST_ATK_INVALID      =   0;
    const int DLA_JOUST_ATK_HELM         =   1;
    const int DLA_JOUST_ATK_DC           =   2;
    const int DLA_JOUST_ATK_CP           =   3;
    const int DLA_JOUST_ATK_SC           =   4;
    const int DLA_JOUST_ATK_DF           =   5;
    const int DLA_JOUST_ATK_FP           =   6;
    const int DLA_JOUST_ATK_SF           =   7;
    const int DLA_JOUST_ATK_BASE         =   8;

// defense
    const int DLA_JOUST_DEF_INVALID      =   0;
    const int DLA_JOUST_DEF_HELM         =   1;
    const int DLA_JOUST_DEF_RIGHT        =   2;
    const int DLA_JOUST_DEF_LEFT         =   3;
    const int DLA_JOUST_DEF_STEADY       =   4;
    const int DLA_JOUST_DEF_HIGH         =   5;
    const int DLA_JOUST_DEF_LOW          =   6;

//jousting outcomes
    const int DLA_OUTCOME_BREAKLANCE     =   0x00000001;
    const int DLA_OUTCOME_GLANCEOFF      =   0x00000002;
    const int DLA_OUTCOME_HELMKNOCKEDOFF =   0x00000004;
    const int DLA_OUTCOME_INJURED        =   0x00000008;
    const int DLA_OUTCOME_MISS           =   0x00000010;
    const int DLA_OUTCOME_UNHORSED       =   0x00000020;

//jousting glancing blow
    const int DLA_JOUST_CONDITION_NORMAL         = 0;
    const int DLA_JOUST_CONDITION_SHAKEN         = 1;
    const int DLA_JOUST_CONDITION_STUNNED        = 2;

//visual effects
    const int VFX_DUR_DLA_SHIELDMAP      =   600;
    const int VFX_FNF_DLA_WOOD_SHATTER   =   601;
    const int VFX_FNF_DLA_WOOD_SHATTER_A =   602;
    const int VFX_FNF_DLA_WOOD_SHATTER_B =   603;
    const int SFX_IMP_LANCEHIT           =   652;
    const int SFX_IMP_JOUSTFALL          =   653;
    const int VFX_DUR_DLA_HORSE_PANIC    =   609;
 // Bill Harper 30 Oct 2019
 // Entry properly added to constants already, so this is a dupe that prevents compiling
//    const int VFX_IMP_NIGHTMARE_HEAD_HIT =   651;
    const int VFX_DUR_HOWLER_QUILL       =   620;
    const int VFX_FNF_SUMMON_PAL_MOUNT   =   VFX_FNF_SUMMON_MONSTER_2;

// Gale 17 Feb 2006:
// ( only available on animated lance rack )
    const int ANIMATION_LANCERACK_REM_YELLOW = ANIMATION_PLACEABLE_ACTIVATE;
    const int ANIMATION_LANCERACK_REM_BLUE   = ANIMATION_PLACEABLE_OPEN;
    const int ANIMATION_LANCERACK_REM_BLACK  = ANIMATION_PLACEABLE_CLOSE;
    const int ANIMATION_LANCERACK_REM_BARE   = ANIMATION_PLACEABLE_DEACTIVATE;
    const int ANIMATION_LANCERACK_FULL       = ANIMATION_LOOPING_CUSTOM1;

//jousting colors available to the player
    const int DLA_JOUST_TAIL_COLOR1         = 57; // Purple
    const int DLA_JOUST_TAIL_COLOR2         = 59; // Black/White
    const int DLA_JOUST_TAIL_COLOR3         = 66; // Turqois
    const int DLA_JOUST_TAIL_COLOR4         = 63; // Pink/Blue
    const int DLA_JOUST_TAIL_COLOR5         = 64; // Brick
    const int DLA_JOUST_TAIL_COLOR6         = 67; // White
    const int DLA_JOUST_TAIL_COLOR7         = 58; // Blue/gold

//joust states
    const int DLA_JOUSTSTATE_T1_1           = 0x0001;
    const int DLA_JOUSTSTATE_T1_2           = 0x0002;
    const int DLA_JOUSTSTATE_T1_3           = 0x0004;
    const int DLA_JOUSTSTATE_T1_4           = 0x0008;

    const int DLA_JOUSTSTATE_T2_1           = 0x0010;
    const int DLA_JOUSTSTATE_T2_2           = 0x0020;
    const int DLA_JOUSTSTATE_T2_3           = 0x0040;
    const int DLA_JOUSTSTATE_T2_4           = 0x0080;

    const int DLA_JOUSTSTATE_T1_STARTED     = 0x0100;
    const int DLA_JOUSTSTATE_T1_LOST        = 0x0200;
    const int DLA_JOUSTSTATE_T1_DONE        = 0x0400;
    const int DLA_JOUSTSTATE_T1_CHAMP       = 0x0800;

    const int DLA_JOUSTSTATE_T2_STARTED     = 0x1000;
    const int DLA_JOUSTSTATE_T2_LOST        = 0x2000;
    const int DLA_JOUSTSTATE_T2_DONE        = 0x4000;
    const int DLA_JOUSTSTATE_T2_CHAMP       = 0x8000;

    const int DLA_EQUIP_ALL     = 0;
    const int DLA_EQUIP_SHIELD  = 1;
    const int DLA_EQUIP_ARMOR   = 2;
    const int DLA_EQUIP_HELM    = 3;

    const int DLA_LANCE_YELLOW  = 1;
    const int DLA_LANCE_BLUE    = 2;
    const int DLA_LANCE_BLACK   = 3;
    const int DLA_LANCE_BARE    = 4;
    const int DLA_LANCE_BK      = 5;

    const string DLA_TAG_JOUST_LANCERACK = "dla_lancerack";
    const string DLA_VAR_BORROWED_SHIELD = "dla_borrowed_shield";
    const string DLA_VAR_BORROWED_ARMOR  = "dla_borrowed_armor";
    const string DLA_VAR_BORROWED_HELMET = "dla_borrowed_helm";

    const string DLA_VAR_OWN_SHIELD      = "dla_own_shield";
    const string DLA_VAR_OWN_ARMOR       = "dla_own_armor";
    const string DLA_VAR_OWN_HELMET      = "dla_own_helm";


////////////////// misc constants /////////////////////

    // Joust basic equipment blueprints
    const string DLA_TAG_JOUST_SHIELD = "dla_joust_shield"; //blueprint
    const string DLA_TAG_JOUST_ARMOR  = "dla_joust_armor";  //blueprint == tag
    const string DLA_TAG_JOUST_LANCE  = "dla_joust_lance";  //blueprint == tag
    const string DLA_TAG_JOUST_HELMET = "dla_joust_helm";   //blueprint == tag

    // Joust lance placeholder
    const string DLA_TAG_JOUST_LANCEHOLDER  = "dla_joust_lanceh";
    // Joust shield placeholder
    const string DLA_TAG_JOUST_SHIELDHOLDER = "dla_joust_shldh";
    // Helmet is stored here when a jouster is unhelmeted
    const string DLA_TAG_JOUST_HELMET_BOX   = "DLA_HELMET_BOX";

    // Jousting armor chest
    const string DLA_TAG_JOUST_ARMOR_CHEST  = "DLA_JOUST_ARMOR_CHEST";

    // Resref tag constants
    const string DLA_TAG_HITCHING_POST      = "DLA_HITCHING_POST";
    const string DLA_TAG_HORSE_PACKS        = "dla_horse_packs";

    //this is the name of the local string variable on a horse that contains the
    //tag of a NPC that is the horse owner.
    const string DLA_TAG_HORSE_NPC_OWNER    = "DLA_TAG_HORSE_NPC_OWNER";
    const string DLA_TAG_HAWKLINHITCH       = "dla_hitch_hawklin";

    const string DLA_VAR_INFAMY             = "dla_infamy";
    const string DLA_VAR_OP_INFAMY          = "dla_op_infamy";
    const string DLA_VAR_STUN_CONDITION     = "dla_stun_condition";
    const string DLA_VAR_OP_STUN_CONDITION  = "dla_opstun_cond";
    const string DLA_VAR_AIM_POS            = "DLA_AIM_POS";
    const string DLA_VAR_DEF_POS            = "DLA_DEF_POS";

    //Name of the local var that will store all outcome of a jousting on a creature
    const string DLA_OUTCOME_MASTER_VAR     = "dla_joust_outcmast";

    //Name of the local var holding tournament champion status
    const string DLA_TOURNEY_CHAMP          = "dla_joust_champion";

    //Jonas jousting constants
    const int DLA_JONAS_HORSE_TAIL          = 64;
    const string DLA_TAG_JONAS              = "Jonas";
    const string DLA_TAG_JONAS_HELMET       = "blackhelm";
    const string DLA_TAG_JONAS_ARMOR        = "blackknight";
    const string DLA_TAG_JONAS_SHIELD       = "blackshield";
    const string DLA_TAG_JONAS_LANCE        = "dla_joust_lanceb";

    //Joust match agent tags
    const string DLA_TAG_JOUST_AGENT_HURIM  = "HurimJoust1";
    const string DLA_TAG_JOUST_AGENT_MARETH = "Mareth";

    // waypoint tag to move unmounted version of horse to
    const string DLA_UNMOUNTED_MOUNT_MOVE   = "WP_HORSE_MOUNT_DUMMY";

    //Spell abilities
    const int SPELLABILITY_QUILLS            = 1609;
    const int SPELLABILITY_HOWL_WISDOMDAMAGE = 1608;
    const int SPELLABILITY_NIGHTMARE_SMOKE   = 1612;

    //AoE effects
    const int AOE_MOB_NIGHTMARE_SMOKE = 51;

    //Death Beam Puzzles
    const int DLA_EVENT_DEATHBEAM_ON        = 1;
    const int DLA_EVENT_DEATHBEAM_OFF       = 2;
    const int DLA_EVENT_DEATHBEAM_TRIGGER   = 3;
    const int DLA_EVENT_DEATHBEAM_DELAY     = 4;

        //Barrow battle events
    const int DLA_EVENT_BARROWEXIT          = 600;
    const int DLA_EVENT_BARROWEXIT_WL       = 601;
    const int DLA_EVENT_BARROWEXIT_JONAS    = 602;
