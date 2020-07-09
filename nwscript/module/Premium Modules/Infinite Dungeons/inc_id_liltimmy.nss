//::///////////////////////////////////////////////
//:: inc_id_liltimmy
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Include file for Little Timmy
*/
//:://////////////////////////////////////////////
//:: Created By: Cori
//:: Created On: 10/06/05
//:://////////////////////////////////////////////

#include "inc_id1_debug"
#include "inc_id1_flags"

const int ID_LOCAL_DUNGEON_NOT_ENTERED = 0;
const int ID_LOCAL_FIRST_DUNGEON_CREATED = 1;
const int ID_LOCAL_FIRST_DUNGEON_COMPLETED = 2;
const int ID_LOCAL_SECOND_DUNGEON_CREATED = 3;
const int ID_LOCAL_SECOND_DUNGEON_COMPLETED = 4;
const int ID_LOCAL_THIRD_DUNGEON_CREATED = 5;
const int ID_LOCAL_THIRD_DUNGEON_COMPLETED = 6;
const int ID_LOCAL_FIRST_BOSS_CREATED = 7;
const int ID_LOCAL_FIRST_BOSS_DEFEATED = 8;
const int ID_LOCAL_SECOND_BOSS_CREATED = 9;
const int ID_LOCAL_SECOND_BOSS_DEFEATED = 10;
const int ID_LOCAL_THIRD_BOSS_CREATED = 11;
const int ID_LOCAL_THIRD_BOSS_DEFEATED = 12;
const int ID_LOCAL_HALASTER_FIGHT = 13;
const int ID_LOCAL_HALASTER_SURRENDER = 14;
const int ID_LOCAL_HALASTER_TIMMY = 15;

const int ID_LOCAL_LIEUTENANT_WEREBOAR = 1;
const int ID_LOCAL_LIEUTENANT_GIANTESS = 2;
const int ID_LOCAL_LIEUTENANT_INSECT = 3;

const int ID_LOCAL_BOSS_DEMON = 1;
const int ID_LOCAL_BOSS_BEHOLDER = 2;
const int ID_LOCAL_BOSS_LICH = 3;

//sets that the PC has spoken with Little Timmy
void lt_SetIsTalkedTo(object oLT = OBJECT_SELF, int nBoolean = TRUE);

//gets if the PC has spoken with Little Timmy
int lt_GetIsTalkedTo(object oLT = OBJECT_SELF);

//sets that the PC has agreed to enter the dungeon
void lt_SetIsEntryAgreed(object oLT = OBJECT_SELF, int nBoolean = TRUE);

//gets if the PC has agreed to enter the dungeon
int lt_GetIsEntryAgreed(object oLT = OBJECT_SELF);

//sets which level of dungeon the pc has started/finished
void lt_SetDungeonLevel(int nState);

//gets which level of dungeon the pc has started/finished
int lt_GetDungeonLevel();

//sets which lieutenant the PC fought first
void lt_SetFirstLieutenant(int nState);

//gets which lieutenant the PC fought first
int lt_GetFirstLieutenant();

//sets which lieutenant the PC fought second
void lt_SetSecondLieutenant(int nState);

//gets which lieutenant the PC fought second
int lt_GetSecondLieutenant();

//sets which lieutenant the PC fought third
void lt_SetThirdLieutenant(int nState);

//gets which lieutenant the PC fought third
int lt_GetThirdLieutenant();

//sets which boss the PC fought first
void lt_SetFirstBoss(int nState);

//gets which boss the PC fought first
int lt_GetFirstBoss();

//sets which boss the PC fought second
void lt_SetSecondBoss(int nState);

//gets which boss the PC fought second
int lt_GetSecondBoss();

//sets which boss the PC fought third
void lt_SetThirdBoss(int nState);

//gets which boss the PC fought third
int lt_GetThirdBoss();

void SetDungeonParameters(int nBossLevel, int nBossNumber);

//*****************************************************************************
//sets that the PC has spoken with Little Timmy
void lt_SetIsTalkedTo(object oLT = OBJECT_SELF, int nBoolean = TRUE)
{
    SetLocalInt(oLT,"ID_LT_TALKED_TO",nBoolean);
}

//gets if the PC has spoken with Little Timmy
int lt_GetIsTalkedTo(object oLT = OBJECT_SELF)
{
    int nResult;
    nResult = GetLocalInt(oLT,"ID_LT_TALKED_TO");
    return nResult;
}

//sets that the PC has agreed to enter the dungeon
void lt_SetIsEntryAgreed(object oLT = OBJECT_SELF, int nBoolean = TRUE)
{
    SetLocalInt(oLT,"ID_LT_PC_AGREED_ENTRY",nBoolean);
}

//gets if the PC has agreed to enter the dungeon
int lt_GetIsEntryAgreed(object oLT = OBJECT_SELF)
{
    int nResult;
    nResult = GetLocalInt(oLT,"ID_LT_PC_AGREED_ENTRY");
    return nResult;
}

//sets which level of dungeon the pc has started/finished
void lt_SetDungeonLevel(int nState)
{
    object oModule = GetModule();
    SetLocalInt(oModule,"ID_MODULE_DUNGEON_LEVEL",nState);
}

//gets which level of dungeon the pc has started/finished
int lt_GetDungeonLevel()
{
    int nResult;
    object oModule = GetModule();
    nResult = GetLocalInt(oModule,"ID_MODULE_DUNGEON_LEVEL");
    return nResult;
}

//sets which lieutenant the PC fought first
void lt_SetFirstLieutenant(int nState)
{
    object oModule = GetModule();
    SetLocalInt(oModule,"ID_MODULE_FIRST_LIEUTENANT",nState);
}

//gets which lieutenant the PC fought first
int lt_GetFirstLieutenant()
{
    int nResult;
    object oModule = GetModule();
    nResult = GetLocalInt(oModule,"ID_MODULE_FIRST_LIEUTENANT");
    return nResult;
}

//sets which lieutenant the PC fought second
void lt_SetSecondLieutenant(int nState)
{
    object oModule = GetModule();
    SetLocalInt(oModule,"ID_MODULE_SECOND_LIEUTENANT",nState);
}

//gets which lieutenant the PC fought second
int lt_GetSecondLieutenant()
{
    int nResult;
    object oModule = GetModule();
    nResult = GetLocalInt(oModule,"ID_MODULE_SECOND_LIEUTENANT");
    return nResult;
}

//sets which lieutenant the PC fought third
void lt_SetThirdLieutenant(int nState)
{
    object oModule = GetModule();
    SetLocalInt(oModule,"ID_MODULE_THIRD_LIEUTENANT",nState);
}

//gets which lieutenant the PC fought third
int lt_GetThirdLieutenant()
{
    int nResult;
    object oModule = GetModule();
    nResult = GetLocalInt(oModule,"ID_MODULE_THIRD_LIEUTENANT");
    return nResult;
}

//sets which boss the PC fought first
void lt_SetFirstBoss(int nState)
{
    object oModule = GetModule();
    SetLocalInt(oModule,"ID_MODULE_FIRST_BOSS",nState);
}

//gets which boss the PC fought first
int lt_GetFirstBoss()
{
    int nResult;
    object oModule = GetModule();
    nResult = GetLocalInt(oModule,"ID_MODULE_FIRST_BOSS");
    return nResult;
}

//sets which boss the PC fought second
void lt_SetSecondBoss(int nState)
{
    object oModule = GetModule();
    SetLocalInt(oModule,"ID_MODULE_SECOND_BOSS",nState);
}

//gets which boss the PC fought second
int lt_GetSecondBoss()
{
    int nResult;
    object oModule = GetModule();
    nResult = GetLocalInt(oModule,"ID_MODULE_SECOND_BOSS");
    return nResult;
}

//sets which boss the PC fought third
void lt_SetThirdBoss(int nState)
{
    object oModule = GetModule();
    SetLocalInt(oModule,"ID_MODULE_THIRD_BOSS",nState);
}

//gets which boss the PC fought third
int lt_GetThirdBoss()
{
    int nResult;
    object oModule = GetModule();
    nResult = GetLocalInt(oModule,"ID_MODULE_THIRD_BOSS");
    return nResult;
}

void SetDungeonParameters(int nBossLevel, int nBossNumber)
{
/*    if (nBossLevel == 1) // lieutenants
    {
        if (nBossNumber == 1) // baccha
        {
            DebugMessage("");
            DebugMessage("Setting boss to Baccha.");
            DebugMessage("");

            SetModuleFlag(ID1_FLAG_THEME_TYPE, ID1_THEME_TYPE_SPECIFIC_SET);
            SetModuleFlagValue(ID1_FLAG_THEME_TYPE, 5);
        } else if (nBossNumber == 2) // hagatha
        {
            DebugMessage("");
            DebugMessage("Setting boss to Hagatha.");
            DebugMessage("");

            SetModuleFlag(ID1_FLAG_THEME_TYPE, ID1_THEME_TYPE_SPECIFIC_SET);
            SetModuleFlagValue(ID1_FLAG_THEME_TYPE, 7);
        } else // maggris
        {
            DebugMessage("");
            DebugMessage("Setting boss to Maggris.");
            DebugMessage("");

            SetModuleFlag(ID1_FLAG_THEME_TYPE, ID1_THEME_TYPE_SPECIFIC_SET);
            SetModuleFlagValue(ID1_FLAG_THEME_TYPE, 6);
        }
    } else if (nBossLevel == 2) // inner circle
    {
        if (nBossNumber == 1) // harat
        {
            DebugMessage("");
            DebugMessage("Setting boss to Harat.");
            DebugMessage("");

            SetModuleFlag(ID1_FLAG_THEME_TYPE, ID1_THEME_TYPE_SPECIFIC_SET);
            SetModuleFlagValue(ID1_FLAG_THEME_TYPE, 2);
        } else if (nBossNumber == 2) // gzhorb
        {
            DebugMessage("");
            DebugMessage("Setting boss to G'Zhorb.");
            DebugMessage("");

            SetModuleFlag(ID1_FLAG_THEME_TYPE, ID1_THEME_TYPE_SPECIFIC_SET);
            SetModuleFlagValue(ID1_FLAG_THEME_TYPE, 3);
        } else // masterius
        {
            DebugMessage("");
            DebugMessage("Setting boss to Masterius.");
            DebugMessage("");

            SetModuleFlag(ID1_FLAG_THEME_TYPE, ID1_THEME_TYPE_SPECIFIC_SET);
            SetModuleFlagValue(ID1_FLAG_THEME_TYPE, 4);
        }
    } else // halaster
    {
        DebugMessage("");
        DebugMessage("Setting boss to Halaster.");
        DebugMessage("");

        SetModuleFlag(ID1_FLAG_THEME_TYPE, ID1_THEME_TYPE_SPECIFIC_SET);
        SetModuleFlagValue(ID1_FLAG_THEME_TYPE, 1);
    }*/
}

