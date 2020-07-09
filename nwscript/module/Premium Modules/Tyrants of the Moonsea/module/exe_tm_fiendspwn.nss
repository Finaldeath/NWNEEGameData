//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: exe_tm_fiendspwn
// DATE: September 1, 2005
// AUTH: Luke Scull
// NOTE: Summons fiends, which attack Voonlar.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////


const string NPC_TAG_BALOR = "VoonlarBalor";
const string NPC_TAG_BRON = "TheBron";
const string NPC_TAG_ZHENTMAGE = "VoonlarZhentarimMage";
const string NPC_TAG_GORMSTADD = "Gormstadd";


void main()
{
    object oBalor = GetObjectByTag(NPC_TAG_BALOR);
    object oBron = GetObjectByTag(NPC_TAG_BRON);
    object oGormstadd = GetObjectByTag(NPC_TAG_GORMSTADD);

    object oPC = OBJECT_SELF;

    // Play combat music
    MusicBattlePlay(GetArea(oPC));

    // Remove Bron and get Gormstadd to shout for help
    object oWaypoint = GetWaypointByTag("WP_Bron_Flee");

    AssignCommand(oBron, SpeakString("What in the Nine Hells? I'm getting out of here."));
    ExecuteScript("hf_cs_exit", oBron);

    DelayCommand(4.0, AssignCommand(oGormstadd, SpeakString("Help us, you fool!")));

// Spawn in fiends
object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("WP_Vrock1_Spawn");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "nw_dmvrock", lTarget);

oTarget = oSpawn;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), GetLocation(oTarget)));

oTarget = GetWaypointByTag("WP_Vrock2_Spawn");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "nw_dmvrock", lTarget);

oTarget = oSpawn;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), GetLocation(oTarget)));

oTarget = GetWaypointByTag("WP_GraySlaad_Spawn");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "nw_slaadgray", lTarget);

oTarget = oSpawn;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), GetLocation(oTarget)));

oTarget = GetWaypointByTag("WP_DeadCow_Spawn");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "cow001", lTarget);

oTarget = GetWaypointByTag("WP_Bebilith_Spawn");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "x2_spiderdemo001", lTarget);

oTarget = oSpawn;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), GetLocation(oTarget)));

oTarget = GetWaypointByTag("WP_Dead_Priest1");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "priestofbane", lTarget);

oTarget = oSpawn;

oTarget = GetWaypointByTag("WP_Dead_Priest2");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "priestofbane", lTarget);

oTarget = oSpawn;

oTarget = GetWaypointByTag("WP_Dead_Priest3");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "priestofbane", lTarget);

oTarget = oSpawn;
}

