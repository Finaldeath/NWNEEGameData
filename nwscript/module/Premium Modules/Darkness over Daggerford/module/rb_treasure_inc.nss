#include "NW_I0_GENERIC"

int GetLootState(int nClass, int nValue);
int TranslateLootClass(int nClass);

const int RB_BARBARIAN       = 0x00000001;
const int RB_BARD            = 0x00000002;
const int RB_CLERIC          = 0x00000004;
const int RB_DRUID           = 0x00000008;
const int RB_FIGHTER         = 0x00000010; //16
const int RB_MONK            = 0x00000020; //32
const int RB_PALADIN         = 0x00000040; //64
const int RB_RANGER          = 0x00000080; //128
const int RB_ROGUE           = 0x00000100; //256
const int RB_SORCERER        = 0x00000200; //512
const int RB_WIZARD          = 0x00000400; //1024

//Determine which class to generate loot for using number of levels of
//multi-classes to determine probability, and taking an educated guess for
//prestige classes (which should be a rarity in this module) as to what items
//may be beneficial to that class
int DetermineLootClass(object oPC)
{
    int nClass;
    int nTotal = GetHitDice(oPC);

    int nClass1 = GetClassByPosition(1, oPC);
    int nClass2 = GetClassByPosition(2, oPC);
    int nClass3;

    //SendMessageToPC(GetFirstPC(), "Class 1 = " + IntToString(nClass1));
    //SendMessageToPC(GetFirstPC(), "Class 2 = " + IntToString(nClass2));

    int nState1 = GetLevelByClass(nClass1, oPC) * 100 / nTotal;
    int nState2;
    int nState3;

    if(nClass2 != CLASS_TYPE_INVALID)
    {
        nClass3 = GetClassByPosition(3, oPC);
        if(nClass3 == CLASS_TYPE_INVALID)
        {
            nState2 = 100;
        }
        else
        {
            nState2 = nState1 + (GetLevelByClass(nClass2, oPC) * 100 / nTotal);
            nState3 = 100;;
        }
    }

    //SendMessageToPC(GetFirstPC(), "State 1 = " + IntToString(nState1));
   //SendMessageToPC(GetFirstPC(), "State 2 = " + IntToString(nState2));
    //SendMessageToPC(GetFirstPC(), "State 3 = " + IntToString(nState3));

    int nUseClass = d100();
    //SendMessageToPC(GetFirstPC(), "Use Class Rand = " + IntToString(nUseClass));
    if(nUseClass <= nState1)
    {
        nClass = nClass1;
    }
    else if(nUseClass > nState1 && nUseClass <= nState2)
    {
        nClass = nClass2;
    }
    else
    {
        nClass = nClass3;
    }
    //SendMessageToPC(GetFirstPC(), "Class = " + IntToString(nClass));
    int nRand = d100();
    //SendMessageToPC(GetFirstPC(), "Rand = " + IntToString(nRand));
    int nLootClass;
    //If it's a prestige class, translate to a basic class
    switch (nClass)
    {
        case CLASS_TYPE_ARCANE_ARCHER:
        {
            if(nRand <= 25)
                nLootClass = CLASS_TYPE_FIGHTER;
            else if(nRand <=50)
                nLootClass = CLASS_TYPE_RANGER;
            else if(nRand <=75)
                nLootClass = CLASS_TYPE_ROGUE;
            else
                nLootClass = CLASS_TYPE_WIZARD;
            break;
        }
        case CLASS_TYPE_ASSASSIN:
        {
            if(nRand <= 50)
                nLootClass = CLASS_TYPE_ROGUE;
            else if(nRand <=75)
                nLootClass = CLASS_TYPE_BARD;
            else
                nLootClass = CLASS_TYPE_MONK;
            break;
        }
        case CLASS_TYPE_BLACKGUARD:
        {
            if(nRand <= 50)
                nLootClass = CLASS_TYPE_FIGHTER;
            else if(nRand <=75)
                nLootClass = CLASS_TYPE_ROGUE;
            else if(nRand <=90)
                nLootClass = CLASS_TYPE_MONK;
            else
                nLootClass = CLASS_TYPE_CLERIC;
            break;
        }
        case CLASS_TYPE_DIVINECHAMPION:
        {
            if(nRand <= 65)
                nLootClass = CLASS_TYPE_PALADIN;
            else
                nLootClass = CLASS_TYPE_CLERIC;
            break;
        }
        case CLASS_TYPE_DRAGONDISCIPLE:
        {
            if(nRand <= 50)
                nLootClass = CLASS_TYPE_SORCERER;
            else
                nLootClass = CLASS_TYPE_BARD;
            break;
        }
        case CLASS_TYPE_DWARVENDEFENDER:
        {
            if(nRand <= 75)
                nLootClass = CLASS_TYPE_FIGHTER;
            else
                nLootClass = CLASS_TYPE_CLERIC;
            break;
        }
        case CLASS_TYPE_HARPER:
        {
            if(nRand <= 40)
                nLootClass = CLASS_TYPE_ROGUE;
            else if(nRand <=80)
                nLootClass = CLASS_TYPE_BARD;
            else if(nRand <=90)
                nLootClass = CLASS_TYPE_RANGER;
            else
                nLootClass = CLASS_TYPE_WIZARD;
            break;
        }
        case CLASS_TYPE_PALEMASTER:
        {
            if(nRand <= 40)
                nLootClass = CLASS_TYPE_WIZARD;
            else if(nRand <=80)
                nLootClass = CLASS_TYPE_SORCERER;
            else
                nLootClass = CLASS_TYPE_BARD;
            break;
        }
        case CLASS_TYPE_PURPLE_DRAGON_KNIGHT:
        {
            if(nRand <= 25)
                nLootClass = CLASS_TYPE_FIGHTER;
            else if(nRand <=50)
                nLootClass = CLASS_TYPE_RANGER;
            else if(nRand <=75)
                nLootClass = CLASS_TYPE_PALADIN;
            else if(nRand <=90)
                nLootClass = CLASS_TYPE_CLERIC;
            else if(nRand <=95)
                nLootClass = CLASS_TYPE_BARD;
            else
                nLootClass = CLASS_TYPE_ROGUE;
            break;
        }
        case CLASS_TYPE_SHADOWDANCER:
        {
            if(nRand <= 65)
                nLootClass = CLASS_TYPE_ROGUE;
            else
                nLootClass = CLASS_TYPE_BARD;
            break;
        }
        case CLASS_TYPE_SHIFTER:
        {
            if(nRand <= 80)
                nLootClass = CLASS_TYPE_DRUID;
            else
                nLootClass = CLASS_TYPE_WIZARD;
            break;
        }
        case CLASS_TYPE_WEAPON_MASTER:
        {
            if(nRand <= 40)
                nLootClass = CLASS_TYPE_FIGHTER;
            else if(nRand <=80)
                nLootClass = CLASS_TYPE_BARBARIAN;
            else
                nLootClass = CLASS_TYPE_MONK;
            break;
        }
        default : nLootClass = nClass;
        break;
    }
    //SendMessageToPC(GetFirstPC(), "Loot Class = " + IntToString(nLootClass));
    return TranslateLootClass(nLootClass);
}

// Variables set on Loot Container are :-
// RB_LOOTCLASS_n - int used to mask classes, e.g for BARD and WIZARD add the
//                  RB_BARD and RB_WIZARD constants to set variable to 1025
// RB_LOOT_n - the loot item blueprint (or tag if possessed) if the mask indicates a match
// RB_LOOT_POSSESSES - set to 1 to indicate it's in a creature's inventory and
//                     its droppable flag can simply be set

void GenerateLoot(object oPC, object oInventory)
{
    if(GetLocalInt(oInventory, "nLootCreated") == 0)
    {
        int i = 1;
        int iLootMask;
        int iPCClass = DetermineLootClass(oPC);
        int iStackSize = 0;

        string sLootClass = "RB_LOOTCLASS_" + IntToString(i);
        string sLoot = "RB_LOOT_" + IntToString(i);
        string sLootItem = "";
        string sLootStack = "RB_LOOT_STACK_" + IntToString(i);

        iLootMask = GetLocalInt(oInventory, sLootClass);
        //SendMessageToPC(oPC, "PC class = " + IntToString(iPCClass));
        //SendMessageToPC(oPC, "Loot mask = " + IntToString(iLootMask));

        while(iLootMask != 0)
        {
            if(GetLootState(iPCClass, iLootMask))
            {
                sLootItem = GetLocalString(oInventory, "RB_LOOT_" + IntToString(i));
                if(sLootItem != "")
                {
                    if(GetLocalInt(OBJECT_SELF, "RB_LOOT_POSSESSES") == 1)
                    {
                        object oItem = GetItemPossessedBy(oInventory, sLootItem);
                        SetDroppableFlag(oItem, TRUE);
                        //SendMessageToPC(oPC, "Droppable flag set");
                    }
                    else
                    {
                        iStackSize = GetLocalInt(OBJECT_SELF, sLootStack);
                        if(iStackSize == 0)
                        {
                            iStackSize = 1;
                        }
                        CreateItemOnObject(sLootItem, oInventory, iStackSize);
                    }
                }
                //break;
            }

            i++;
            sLootClass = "RB_LOOTCLASS_" + IntToString(i);
            sLootStack = "RB_LOOT_STACK_" + IntToString(i);
            iLootMask = GetLocalInt(oInventory, sLootClass);
            //SendMessageToPC(oPC, "Loot mask = " + IntToString(iLootMask));
        }

        SetLocalInt(oInventory, "nLootCreated", 1);
    }
}

// Returns TRUE if the specified loot class flag is set in the supplied mask
int GetLootState(int nClass, int nMask)
{
    if(nClass & nMask)
    {
        //SendMessageToPC(GetFirstPC(), "Loot class match");
        return TRUE;
    }
    //SendMessageToPC(GetFirstPC(), "No Loot class match");
    return FALSE;
}

//Convert the class to one of the mask values defined as constants in this file
int TranslateLootClass(int nClass)
{
    int iLootClass;

    switch(nClass)
    {
        case CLASS_TYPE_BARBARIAN:
        {
            iLootClass = RB_BARBARIAN;
            break;
        }
        case CLASS_TYPE_BARD:
        {
            iLootClass = RB_BARD;
            break;
        }
        case CLASS_TYPE_CLERIC:
        {
            iLootClass = RB_CLERIC;
            break;
        }
        case CLASS_TYPE_DRUID:
        {
            iLootClass = RB_DRUID;
            break;
        }
        case CLASS_TYPE_FIGHTER:
        {
            iLootClass = RB_FIGHTER;
            break;
        }
        case CLASS_TYPE_MONK:
        {
            iLootClass = RB_MONK;
            break;
        }
        case CLASS_TYPE_PALADIN:
        {
            iLootClass = RB_PALADIN;
            break;
        }
        case CLASS_TYPE_RANGER:
        {
            iLootClass = RB_RANGER;
            break;
        }
        case CLASS_TYPE_ROGUE:
        {
            iLootClass = RB_ROGUE;
            break;
        }
        case CLASS_TYPE_SORCERER:
        {
            iLootClass = RB_SORCERER;
            break;
        }
        case CLASS_TYPE_WIZARD:
        {
            iLootClass = RB_WIZARD;
            break;
        }
        default:
        {
            iLootClass = RB_FIGHTER;
            break;
        }
    }

    return iLootClass;
}

/*void main()
{
} */
