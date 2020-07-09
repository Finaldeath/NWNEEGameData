// creates class-specific loot in a container based on variables

// create an item in the chest
object CreateItem(string sTag, int nStackSize=0)
{
    // we weren't given a stack size, so try to find the max stack size
    if (nStackSize == 0)
    {
        object o = CreateObject(OBJECT_TYPE_ITEM, sTag, GetLocation(OBJECT_SELF));
        SetItemStackSize(o, 99);
        nStackSize = GetItemStackSize(o);
        DestroyObject(o);
    }

    object o = CreateItemOnObject(sTag, OBJECT_SELF, nStackSize);
    if (GetLocalInt(OBJECT_SELF, "HF_TREASURE_IDENTIFY"))
    {
        SetIdentified(o, TRUE);
    }
    return(o);
}

// make a weapon suitable for this character
object CreateWeaponOfChoice(object oPC, int nBonus)
{
    string s = "";

    // weapon of choice
    if      (GetHasFeat(FEAT_WEAPON_OF_CHOICE_BASTARDSWORD, oPC))   s = "nw_wswbs001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_BATTLEAXE, oPC))      s = "nw_waxbt001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_CLUB, oPC))           s = "nw_wblcl001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_DAGGER, oPC))         s = "nw_wswdg001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_DIREMACE, oPC))       s = "nw_wdbma001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_DOUBLEAXE, oPC))      s = "nw_wdbax001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_DWAXE, oPC))          s = "x2_wdwraxe001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_GREATAXE, oPC))       s = "nw_waxgr001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_GREATSWORD, oPC))     s = "nw_wswgs001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_HALBERD, oPC))        s = "nw_wplhb001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_HANDAXE, oPC))        s = "nw_waxhn001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_HEAVYFLAIL, oPC))     s = "nw_wblfh001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_KAMA, oPC))           s = "nw_wspka001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_KATANA, oPC))         s = "nw_wswka001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_KUKRI, oPC))          s = "nw_wspku001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_LIGHTFLAIL, oPC))     s = "nw_wblfl001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_LIGHTHAMMER, oPC))    s = "nw_wblmhl001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_LIGHTMACE, oPC))      s = "nw_wblml001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_LONGSWORD, oPC))      s = "nw_wswls001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_MORNINGSTAR, oPC))    s = "nw_wblms001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_RAPIER, oPC))         s = "nw_wswrp001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_SCIMITAR, oPC))       s = "nw_wswsc001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_SCYTHE, oPC))         s = "nw_wplsc001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_SHORTSWORD, oPC))     s = "nw_wswss001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_SICKLE, oPC))         s = "nw_wspsc001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_SHORTSPEAR, oPC))     s = "nw_wplss001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_QUARTERSTAFF, oPC))   s = "nw_wdbqs001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_TWOBLADEDSWORD, oPC)) s = "nw_wdbsw001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_WARHAMMER, oPC))      s = "nw_wblhw001";
    else if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_WHIP, oPC))           s = "x2_it_wpwhip";

    // weapon specialization
    if (s == "")
    {
        if      (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_BASTARD_SWORD, oPC))    s = "nw_wswbs001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_BATTLE_AXE, oPC))       s = "nw_waxbt001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_CLUB, oPC))             s = "nw_wblcl001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_DAGGER, oPC))           s = "nw_wswdg001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_DART, oPC))             s = "nw_wthdt001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_DIRE_MACE, oPC))        s = "nw_wdbma001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_DOUBLE_AXE, oPC))       s = "nw_wdbax001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_DWAXE, oPC))            s = "x2_wdwraxe001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_GREAT_AXE, oPC))        s = "nw_waxgr001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_GREAT_SWORD, oPC))      s = "nw_wswgs001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_HALBERD, oPC))          s = "nw_wplhb001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_HAND_AXE, oPC))         s = "nw_waxhn001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_HEAVY_CROSSBOW, oPC))   s = "nw_wbwxh001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_HEAVY_FLAIL, oPC))      s = "nw_wblfh001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_KAMA, oPC))             s = "nw_wspka001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_KATANA, oPC))           s = "nw_wswka001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_KUKRI, oPC))            s = "nw_wspku001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_LIGHT_CROSSBOW, oPC))   s = "nw_wbwxl001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_LIGHT_FLAIL, oPC))      s = "nw_wblfl001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_LIGHT_HAMMER, oPC))     s = "nw_wblmhl001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_LIGHT_MACE, oPC))       s = "nw_wblml001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_LONG_SWORD, oPC))       s = "nw_wswls001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_LONGBOW, oPC))          s = "nw_wbwln001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_MORNING_STAR, oPC))     s = "nw_wblms001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_RAPIER, oPC))           s = "nw_wswrp001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SCIMITAR, oPC))         s = "nw_wswsc001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SCYTHE, oPC))           s = "nw_wplsc001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SHORT_SWORD, oPC))      s = "nw_wswss001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SHORTBOW, oPC))         s = "nw_wbwsh001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SHURIKEN, oPC))         s = "nw_wthsh001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SICKLE, oPC))           s = "nw_wspsc001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SLING, oPC))            s = "nw_wbwsl001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SPEAR, oPC))            s = "nw_wplss001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_STAFF, oPC))            s = "nw_wdbqs001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_THROWING_AXE, oPC))     s = "nw_wthax001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_TWO_BLADED_SWORD, oPC)) s = "nw_wdbsw001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_UNARMED_STRIKE, oPC))   s = "";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_WAR_HAMMER, oPC))       s = "nw_wblhw001";
        else if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_WHIP, oPC))             s = "x2_it_wpwhip";
    }

    // improved critical
    if (s == "")
    {
        if      (GetHasFeat(FEAT_IMPROVED_CRITICAL_BASTARD_SWORD, oPC))    s = "nw_wswbs001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_BATTLE_AXE, oPC))       s = "nw_waxbt001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_CLUB, oPC))             s = "nw_wblcl001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_DAGGER, oPC))           s = "nw_wswdg001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_DART, oPC))             s = "nw_wthdt001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_DIRE_MACE, oPC))        s = "nw_wdbma001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_DOUBLE_AXE, oPC))       s = "nw_wdbax001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_DWAXE, oPC))            s = "x2_wdwraxe001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_GREAT_AXE, oPC))        s = "nw_waxgr001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_GREAT_SWORD, oPC))      s = "nw_wswgs001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_HALBERD, oPC))          s = "nw_wplhb001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_HAND_AXE, oPC))         s = "nw_waxhn001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_HEAVY_CROSSBOW, oPC))   s = "nw_wbwxh001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_HEAVY_FLAIL, oPC))      s = "nw_wblfh001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_KAMA, oPC))             s = "nw_wspka001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_KATANA, oPC))           s = "nw_wswka001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_KUKRI, oPC))            s = "nw_wspku001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_LIGHT_CROSSBOW, oPC))   s = "nw_wbwxl001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_LIGHT_FLAIL, oPC))      s = "nw_wblfl001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_LIGHT_HAMMER, oPC))     s = "nw_wblmhl001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_LIGHT_MACE, oPC))       s = "nw_wblml001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_LONG_SWORD, oPC))       s = "nw_wswls001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_LONGBOW, oPC))          s = "nw_wbwln001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_MORNING_STAR, oPC))     s = "nw_wblms001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_RAPIER, oPC))           s = "nw_wswrp001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_SCIMITAR, oPC))         s = "nw_wswsc001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_SCYTHE, oPC))           s = "nw_wplsc001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_SHORT_SWORD, oPC))      s = "nw_wswss001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_SHORTBOW, oPC))         s = "nw_wbwsh001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_SHURIKEN, oPC))         s = "nw_wthsh001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_SICKLE, oPC))           s = "nw_wspsc001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_SLING, oPC))            s = "nw_wbwsl001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_SPEAR, oPC))            s = "nw_wplss001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_STAFF, oPC))            s = "nw_wdbqs001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_THROWING_AXE, oPC))     s = "nw_wthax001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_TWO_BLADED_SWORD, oPC)) s = "nw_wdbsw001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_UNARMED_STRIKE, oPC))   s = "";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_WAR_HAMMER, oPC))       s = "nw_wblhw001";
        else if (GetHasFeat(FEAT_IMPROVED_CRITICAL_WHIP, oPC))             s = "x2_it_wpwhip";
    }

    // weapon focus
    if (s == "")
    {
        if      (GetHasFeat(FEAT_WEAPON_FOCUS_BASTARD_SWORD, oPC))    s = "nw_wswbs001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_BATTLE_AXE, oPC))       s = "nw_waxbt001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_CLUB, oPC))             s = "nw_wblcl001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_DAGGER, oPC))           s = "nw_wswdg001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_DART, oPC))             s = "nw_wthdt001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_DIRE_MACE, oPC))        s = "nw_wdbma001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_DOUBLE_AXE, oPC))       s = "nw_wdbax001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_DWAXE, oPC))            s = "x2_wdwraxe001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_GREAT_AXE, oPC))        s = "nw_waxgr001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_GREAT_SWORD, oPC))      s = "nw_wswgs001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_HALBERD, oPC))          s = "nw_wplhb001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_HAND_AXE, oPC))         s = "nw_waxhn001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_HEAVY_CROSSBOW, oPC))   s = "nw_wbwxh001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_HEAVY_FLAIL, oPC))      s = "nw_wblfh001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_KAMA, oPC))             s = "nw_wspka001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_KATANA, oPC))           s = "nw_wswka001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_KUKRI, oPC))            s = "nw_wspku001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_LIGHT_CROSSBOW, oPC))   s = "nw_wbwxl001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_LIGHT_FLAIL, oPC))      s = "nw_wblfl001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_LIGHT_HAMMER, oPC))     s = "nw_wblmhl001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_LIGHT_MACE, oPC))       s = "nw_wblml001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_LONG_SWORD, oPC))       s = "nw_wswls001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_LONGBOW, oPC))          s = "nw_wbwln001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_MORNING_STAR, oPC))     s = "nw_wblms001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_RAPIER, oPC))           s = "nw_wswrp001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_SCIMITAR, oPC))         s = "nw_wswsc001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_SCYTHE, oPC))           s = "nw_wplsc001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_SHORT_SWORD, oPC))      s = "nw_wswss001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_SHORTBOW, oPC))         s = "nw_wbwsh001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_SHURIKEN, oPC))         s = "nw_wthsh001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_SICKLE, oPC))           s = "nw_wspsc001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_SLING, oPC))            s = "nw_wbwsl001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_SPEAR, oPC))            s = "nw_wplss001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_STAFF, oPC))            s = "nw_wdbqs001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_THROWING_AXE, oPC))     s = "nw_wthax001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_TWO_BLADED_SWORD, oPC)) s = "nw_wdbsw001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_UNARMED_STRIKE, oPC))   s = "";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_WAR_HAMMER, oPC))       s = "nw_wblhw001";
        else if (GetHasFeat(FEAT_WEAPON_FOCUS_WHIP, oPC))             s = "x2_it_wpwhip";
    }

    // no fancy specializations, so just create something useful
    if (s == "")
    {
        if ((GetLevelByClass(CLASS_TYPE_FIGHTER, oPC) > 0) ||
            (GetLevelByClass(CLASS_TYPE_RANGER, oPC) > 0)  ||
            (GetLevelByClass(CLASS_TYPE_PALADIN, oPC) > 0))
        {
            if (GetCreatureSize(oPC) == CREATURE_SIZE_SMALL)
            {
                s = "nw_wswss001"; // short sword
            }
            else
            {
                s = "nw_wswls001"; // long sword
            }
        }
        else if (GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC) > 0) s = "nw_waxbt001";  //battle axe
        else if (GetLevelByClass(CLASS_TYPE_CLERIC, oPC) > 0)    s = "nw_wblml001";  //mace
        else if (GetLevelByClass(CLASS_TYPE_DRUID, oPC) > 0)     s = "nw_wspsc001";  //sickle
        else if (GetLevelByClass(CLASS_TYPE_ROGUE, oPC) > 0)     s = "nw_wswss001";  //short sword
        else if (GetLevelByClass(CLASS_TYPE_MONK, oPC) > 0)      s = "nw_wspka001";  //kama
        else if (GetLevelByClass(CLASS_TYPE_WIZARD, oPC) > 0)    s = "nw_wswdg001";  //dagger

    // give up! just create a simple weapon that anyone can use
    if(s == "")
    {
        int n = d4();
            if      (n == 1) s = "nw_wswdg001"; // dagger
            else if (n == 2) s = "nw_wblcl001"; // club
            else if (n == 3) s = "nw_wthdt001"; // dart
            else if (n == 4) s = "nw_wbwsl001"; // sling
        }
    }

    // create item and apply bonuses (if any)
    object oItem = CreateItem(s);
    if (nBonus > 0 && nBonus < 21)
    {
        itemproperty ip;
        if (!GetWeaponRanged(oItem))
        {
            ip = ItemPropertyEnhancementBonus(nBonus);
        } else {
            ip = ItemPropertyAttackBonus(nBonus);
        }
        AddItemProperty(DURATION_TYPE_PERMANENT, ip, oItem);
        string sName = GetName(oItem) + " +" + IntToString(nBonus);
        SetName(oItem, sName);
    }

    return(oItem);
}

// make armour suitable for this character
object CreateArmourOfChoice(object oPC, int nBonus)
{
    string s = "";

    if      (GetHasFeat(FEAT_ARMOR_PROFICIENCY_HEAVY, oPC))
    {
        int n = d3();
        if      (n == 1) s = "nw_aarcl011"; // banded mail
        else if (n == 2) s = "nw_aarcl007"; // full plate
        else if (n == 3) s = "nw_aarcl005"; // splint mail
    }
    else if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_MEDIUM, oPC))
    {
        int n = d4();
        if      (n == 1) s = "nw_aarcl010"; // breast plate
        else if (n == 2) s = "nw_aarcl004"; // chain mail
        else if (n == 3) s = "nw_aarcl012"; // chain shirt
        else if (n == 4) s = "nw_aarcl003"; // scale mail
    }
    else if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_LIGHT, oPC))
    {
        int n = d4();
        if      (n == 1) s = "nw_aarcl001"; // leather
        else if (n == 2) s = "nw_aarcl009"; // padded
        else if (n == 3) s = "nw_aarcl002"; // stud leather
        else if (n == 4) s = "nw_aarcl008"; // hide
    }

    // some classes can't use any armor, so just exit
    if (s == "")
    {
        return(OBJECT_INVALID);
    }

    object oItem = CreateItem(s);
    if (nBonus > 0 && nBonus < 21)
    {
        itemproperty ip = ItemPropertyACBonus(nBonus);
        AddItemProperty(DURATION_TYPE_PERMANENT, ip, oItem);
        string sName = GetName(oItem) + " +" + IntToString(nBonus);
        SetName(oItem, sName);
    }

    return(oItem);
}

// make a healing potion appropriate for the player's level
object CreateHealingPotionOfChoice(object oPC)
{
    string s = "";
    int nLevel = GetHitDice(oPC);

    if      (nLevel >= 11) s = "nw_it_mpotion012"; // heal
    else if (nLevel >= 7)  s = "nw_it_mpotion003"; // cure critical wounds
    else if (nLevel >= 5)  s = "nw_it_mpotion002"; // cure serious wounds
    else if (nLevel >= 3)  s = "nw_it_mpotion020"; // cure moderate wounds
    else if (nLevel >= 1)  s = "nw_it_mpotion001"; // cure light wounds

    // if we didn't find any potions, just exit
    if (s == "")
    {
        return(OBJECT_INVALID);
    }

    object oItem = CreateItem(s);
    return(oItem);
}

// convert a class number to a string
string GetClassName(int n)
{
    if      (n == CLASS_TYPE_ARCANE_ARCHER)         return("ARCANE_ARCHER");
    else if (n == CLASS_TYPE_ASSASSIN)              return("ASSASSIN");
    else if (n == CLASS_TYPE_BARBARIAN)             return("BARBARIAN");
    else if (n == CLASS_TYPE_BARD)                  return("BARD");
    else if (n == CLASS_TYPE_BLACKGUARD)            return("BLACKGUARD");
    else if (n == CLASS_TYPE_CLERIC)                return("CLERIC");
    else if (n == CLASS_TYPE_DRAGON_DISCIPLE)       return("DRAGON_DISCIPLE");
    else if (n == CLASS_TYPE_DRUID)                 return("DRUID");
    else if (n == CLASS_TYPE_DWARVEN_DEFENDER)      return("DWARVEN_DEFENDER");
    else if (n == CLASS_TYPE_DIVINE_CHAMPION)       return("DIVINE_CHAMPION");
    else if (n == CLASS_TYPE_DIVINECHAMPION)        return("DIVINE_CHAMPION");
    else if (n == CLASS_TYPE_DRAGONDISCIPLE)        return("DRAGONDISCIPLE");
    else if (n == CLASS_TYPE_DWARVENDEFENDER)       return("DWARVEN_DEFENDER");
    else if (n == CLASS_TYPE_FIGHTER)               return("FIGHTER");
    else if (n == CLASS_TYPE_HARPER)                return("HARPER");
    else if (n == CLASS_TYPE_MONK)                  return("MONK");
    else if (n == CLASS_TYPE_PALADIN)               return("PALADIN");
    else if (n == CLASS_TYPE_PALE_MASTER)           return("PALE_MASTER");
    else if (n == CLASS_TYPE_PALEMASTER)            return("PALEMASTER");
    else if (n == CLASS_TYPE_RANGER)                return("RANGER");
    else if (n == CLASS_TYPE_ROGUE)                 return("ROGUE");
    else if (n == CLASS_TYPE_SHADOWDANCER)          return("SHADOW_DANCER");
    else if (n == CLASS_TYPE_SHIFTER)               return("SHIFTER");
    else if (n == CLASS_TYPE_SORCERER)              return("SORCERER");
    else if (n == CLASS_TYPE_WEAPON_MASTER)         return("WEAPON_MASTER");
    else if (n == CLASS_TYPE_WIZARD)                return("WIZARD");
    return("DEFAULT");
}

// get the player's highest class for which a treasure is defined
int GetHighestClass(object oPC)
{
    int nMaxClass = CLASS_TYPE_INVALID;
    int nMaxLevel = 0;
    int i;
    for (i=1; i<=3; i++)
    {
        int nClass = GetClassByPosition(i, oPC);
        if (nClass != CLASS_TYPE_INVALID)
        {
            int nLevel = GetLevelByClass(nClass, oPC);
            if (nLevel > nMaxLevel &&
                GetLocalString(OBJECT_SELF, "HF_TREASURE_"+GetClassName(nClass)) != "")
            {
                nMaxLevel = nLevel;
                nMaxClass = nClass;
            }
        }
    }
    return(nMaxClass);
}

// get the total value of the player's inventory
int GetPlayersLootValue(object oPC)
{
    int nSum = 0;
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        nSum += GetGoldPieceValue(oItem);
        oItem = GetNextItemInInventory(oPC);
    }
    int nSlot = 0;
    for (nSlot = 0; nSlot < NUM_INVENTORY_SLOTS; nSlot++)
    {
        oItem = GetItemInSlot(nSlot, oPC);
        if (GetIsObjectValid(oItem))
        {
            nSum += GetGoldPieceValue(oItem);
        }
    }
    return(nSum);
}

void main()
{
    // only do this once
    if (GetLocalInt(OBJECT_SELF, "nDone") != 0)
    {
        return;
    }
    SetLocalInt(OBJECT_SELF, "nDone", 1);

    // find the player who opened this chest (or the first player)
    object oPC = GetLastOpenedBy();
    if (!GetIsObjectValid(oPC) || !GetIsPC(oPC))
    {
        oPC = GetFirstPC();
    }

    // check if the player is too rich for bonus loot
    int nLootLimit = GetLocalInt(OBJECT_SELF, "HF_TREASURE_LIMIT");
    if (nLootLimit > 0)
    {
        if (GetPlayersLootValue(oPC) > nLootLimit)
        {
            return;
        }
    }

    // process special weapon and armor loot
    int nBonus = GetLocalInt(OBJECT_SELF, "HF_TREASURE_WEAPON");
    if (nBonus != 0)
        CreateWeaponOfChoice(oPC, nBonus);
    nBonus = GetLocalInt(OBJECT_SELF, "HF_TREASURE_ARMOR");
    if (nBonus == 0)
        nBonus = GetLocalInt(OBJECT_SELF, "HF_TREASURE_ARMOUR");
    if (nBonus != 0)
        CreateArmourOfChoice(oPC, nBonus);

    // lookup the player's highest class for which treasure is defined
    string sClass = GetClassName(GetHighestClass(oPC));
    string sList = GetLocalString(OBJECT_SELF, "HF_TREASURE_"+sClass);
    if (sList == "")
    {
        sList = GetLocalString(OBJECT_SELF, "HF_TREASURE_DEFAULT");
    }
    if (sList == "")
    {
        return;
    }

    // create each item in the treasure list inside the chest
    while(TRUE)
    {
        int nPos = FindSubString(sList, ",");
        if (nPos <= 0)
        {
            CreateItem(sList);
            break;
        }
        string s = GetStringLeft(sList, nPos);
        sList = GetStringRight(sList, GetStringLength(sList) - nPos - 1);
        CreateItem(s);
    }
}

/*
This script creates class-specific treasure on a container based on the
highest class of the player character who opened it. If the player's
highest class does not have a treasure defined, the next highest class
will be used. If none of the player's classes are listed, the DEFAULT
list will be used. If there is no default list, nothing happens.
You can still, of course, also statically place objects inside the
container (these items are ignored by this script).

CHEST
- HF_TREASURE_WEAPON
   When set to a non-zero number, the weapon most appropriate to the
   PC will be created. This takes into account weapon specialization
   feats. The value of this variable is the enhancement bonus of the
   weapon created. Set to -1 for a plain weapon. Note there are no
   "unarmed combat" weapons, so give monks won't be happy.
- HF_TREASURE_ARMOR
   When set to a non-zero number, a suitable armor for the PC will
   be created. The value of this variable is the enhancement bonus of
   the armor created. Set to -1 for a plain armor. Note that some
   classes, such as monks, have no appropriate armor, so none is
   created.
- HF_TREASURE_IDENTIFY
   Set to 1 if you want everything created identified.
- HF_TREASURE_LIMIT
   If the player's gold exceeds this amount, no loot is generated.
   This variable is only examined if its value is > 0 of course.
- HF_TREASURE_FIGHTER = "x,y,z"
   Comma-separated list of loot blueprints for fighters.
- HF_TREASURE_ROGUE = "x,a,b"
   Comma-separated list of loot blueprints for rogues.
- HF_TREASURE_...
   (All classes are defined.)
- HF_TREASURE_DEFAULT = "z,x"
   Used if no matches were detected. For example, you could define
   a chest with fighter loot, and non-fighters will get this default
   loot (but fighters won't).
*/
