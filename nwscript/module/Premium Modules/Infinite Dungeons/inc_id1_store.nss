#include "x2_inc_itemprop"
#include "inc_id1_items"

object GenerateStore(int nPartyLevel, object oLocation);

object GenerateStore(int nPartyLevel, object oLocation)
{
    // create store object
    object oStore = CreateObject(OBJECT_TYPE_STORE, "id1_store", GetLocation(oLocation));

    object oItem;

    if (nPartyLevel < 1)
    {
        nPartyLevel = 1;
    }

    // bonus based on level (1-4 +0, 5-8 + 1, 9-12 + 2, 13-16 + 3, 17-20 +4)
    int nBonusBase = nPartyLevel - 4;
    int nBonus = nBonusBase / 4;
    if (nBonus < 1)
    {
        nBonus = 0;
    }
    if ((nBonus * 4) < nBonusBase)
    {
        nBonus++;
    }

    if (nBonus > 20)
    {
        nBonus = 20;
    }

    // spawn in inventory
    if (nBonus == 0)
    {
        // add mundane items

        // melee weapons
        oItem = CreateItemOnObject("nw_waxgr001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wdwraxe001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_waxhn001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_waxbt001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wswbs001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wswdg001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wswgs001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wswgs001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wswka001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wswrp001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wswsc001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wswss001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wblcl001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wblfh001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wblfl001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wblhl001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wblhw001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wblml001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wblms001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wdbma001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wdbax001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wdbqs001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wdbsw001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wspka001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wspku001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wspsc001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("x2_it_wpwhip", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wplhb001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wplsc001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wplss001", oStore);
        //SetInfiniteFlag(oItem, TRUE);

        // ranged weapons
        oItem = CreateItemOnObject("nw_wbwxh001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wbwxl001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wbwln001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wbwsh001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wbwsl001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wthdt001", oStore, 99);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wthsh001", oStore, 99);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wthax001", oStore, 99);
        //SetInfiniteFlag(oItem, TRUE);

        // ammunition
        oItem = CreateItemOnObject("nw_wamar001", oStore, 99);
        SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wambo001", oStore, 99);
        SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_wambu001", oStore, 99);
        SetInfiniteFlag(oItem, TRUE);

        // armor
        oItem = CreateItemOnObject("id_mcloth2", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_aarcl011", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_aarcl007", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_aarcl006", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_aarcl005", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_aarcl012", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_aarcl001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_aarcl009", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_aarcl002", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_aarcl010", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_aarcl004", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_aarcl008", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_aarcl003", oStore);
        //SetInfiniteFlag(oItem, TRUE);

        // shields
        oItem = CreateItemOnObject("nw_ashlw001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_ashsw001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        oItem = CreateItemOnObject("nw_ashto001", oStore);
        //SetInfiniteFlag(oItem, TRUE);
    } else
    {
        // add enhanced items

        // melee weapons
        oItem = CreateItemOnObject("id_mgaxe", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mdwaxe", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mhmaxe", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mbaxe", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mbsword", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mdagger", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mgsword", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mlsword", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mkatana", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mrapier", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mscimitar", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mssword", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mclub", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mhflail", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mlflail", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mlhammer", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mwhammer", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mmace", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mmstar", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mdmace", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mdaxe", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mqstaff", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_m2bsword", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mkama", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mkukri", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_msickle", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mwhip", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mhalberd", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mscythe", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mspear", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);

        // ranged weapons
        oItem = CreateItemOnObject("id_mhxbow", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyAttackBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mlxbow", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyAttackBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mlbow", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyAttackBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_msbow", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyAttackBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_msling", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyAttackBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mdart", oStore, 99);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mshuriken", oStore, 99);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mtaxe", oStore, 99);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
        SetItemName(oItem);

        // ammunition
        oItem = CreateItemOnObject("id_marrow", oStore, 99);
        SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING, nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mbolt", oStore, 99);
        SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING, nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mbullet", oStore, 99);
        SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING, nBonus));
        SetItemName(oItem);

        // armor
        oItem = CreateItemOnObject("id_mcloth", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mbanded", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mfplate", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mhplate", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_msmail", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mcshirt", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mleather", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mpadded", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mstudded", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mbreast", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mchain", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mhide", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mscale", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
        SetItemName(oItem);

        // shields
        oItem = CreateItemOnObject("id_mlarge", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_msmall", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
        SetItemName(oItem);
        oItem = CreateItemOnObject("id_mtower", oStore);
        //SetInfiniteFlag(oItem, TRUE);
        IPRemoveAllItemProperties(oItem, DURATION_TYPE_PERMANENT);
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
        SetItemName(oItem);
    }


    // healing potions

    // cure light wounds
    oItem = CreateItemOnObject("nw_it_mpotion001", oStore); // d8
    SetInfiniteFlag(oItem, TRUE);

    if (nPartyLevel > 3)
    {
        // cure moderate wounds
        oItem = CreateItemOnObject("nw_it_mpotion020", oStore); // 2d8
        SetInfiniteFlag(oItem, TRUE);
    }

    if (nPartyLevel > 6)
    {
        // cure serious wounds
        oItem = CreateItemOnObject("nw_it_mpotion002", oStore); // 3d8
        SetInfiniteFlag(oItem, TRUE);
    }

    if (nPartyLevel > 9)
    {
        // cure critical wounds
        oItem = CreateItemOnObject("nw_it_mpotion002", oStore); // 4d8
        SetInfiniteFlag(oItem, TRUE);
    }

    if (nPartyLevel > 12)
    {
        // heal
        oItem = CreateItemOnObject("nw_it_mpotion012", oStore); // all
        SetInfiniteFlag(oItem, TRUE);
    }

    // lesser restoration potion
    oItem = CreateItemOnObject("NW_IT_MPOTION011", oStore);
    SetInfiniteFlag(oItem, TRUE);

    if (nPartyLevel > 9)
    {
        // restoration potion
        oItem = CreateItemOnObject("id_potion048", oStore);
        SetInfiniteFlag(oItem, TRUE);
    }

    // antidote potion
    oItem = CreateItemOnObject("NW_IT_MPOTION006", oStore);
    SetInfiniteFlag(oItem, TRUE);

    // remove fear
    oItem = CreateItemOnObject("id_potion056", oStore);
    SetInfiniteFlag(oItem, TRUE);

    if (nPartyLevel > 3)
    {
        // remove paralysis
        oItem = CreateItemOnObject("id_potion057", oStore);
        SetInfiniteFlag(oItem, TRUE);
    }

    if (nPartyLevel > 6)
    {
        // remove disease
        oItem = CreateItemOnObject("id_potion045", oStore);
        SetInfiniteFlag(oItem, TRUE);

        // remove blindness/deafness
        oItem = CreateItemOnObject("id_potion052", oStore);
        SetInfiniteFlag(oItem, TRUE);
    }

    if (nPartyLevel > 9)
    {
        // remove curse
        oItem = CreateItemOnObject("id_potion031", oStore);
        SetInfiniteFlag(oItem, TRUE);
    }

    // magic bags
    if (nPartyLevel >= 3)
    {
        oItem = CreateItemOnObject("NW_IT_CONTAIN001", oStore);
        SetInfiniteFlag(oItem, TRUE);
    }

    if (nPartyLevel >= 6)
    {
        oItem = CreateItemOnObject("NW_IT_CONTAIN002", oStore);
        SetInfiniteFlag(oItem, TRUE);
    }

    if (nPartyLevel >= 9)
    {
        oItem = CreateItemOnObject("NW_IT_CONTAIN003", oStore);
        SetInfiniteFlag(oItem, TRUE);
    }

    if (nPartyLevel >= 12)
    {
        oItem = CreateItemOnObject("NW_IT_CONTAIN004", oStore);
        SetInfiniteFlag(oItem, TRUE);
    }

    if (nPartyLevel >= 15)
    {
        oItem = CreateItemOnObject("NW_IT_CONTAIN005", oStore);
        SetInfiniteFlag(oItem, TRUE);
    }

    if (nPartyLevel >= 18)
    {
        oItem = CreateItemOnObject("NW_IT_CONTAIN006", oStore);
        SetInfiniteFlag(oItem, TRUE);
    }

    nBonus = nPartyLevel / 2;
    if (nBonus < 1)
    {
        nBonus = 1;
    }
    if (nBonus > 12)
    {
        nBonus = 12;
    }

    // healer kits
    oItem = CreateItemOnObject("id_medikit", oStore);
    SetInfiniteFlag(oItem, TRUE);
    IPSafeAddItemProperty(oItem, ItemPropertyHealersKit(nBonus));
    SetItemName(oItem);

    // thieves tools
    oItem = CreateItemOnObject("id_thieftool", oStore);
    SetInfiniteFlag(oItem, TRUE);
    IPSafeAddItemProperty(oItem, ItemPropertyThievesTools(nBonus));
    SetItemName(oItem);

    // torches
    oItem = CreateItemOnObject("nw_it_torch001", oStore);
    SetInfiniteFlag(oItem, TRUE);

    // portable camp
    if (TRUE)
    {
        oItem = CreateItemOnObject("id1_portcamp", oStore);
    }

    // spell scrolls (5 = 1, 7 = 2, 9 = 3, 11 = 4, 13 = 5, 15 = 6, 17 = 7, 19 = 8, 21 = 9)
    int nScrollLevel = (nPartyLevel - 3) / 2;
    if (nScrollLevel < 0)
    {
        nScrollLevel = 0;
    }
    if (nScrollLevel > 9)
    {
        nScrollLevel = 9;
    }

    // go through each level of spells
    int nLevel = 0;
    int nScrollNum;
    int nScroll;
    string sScroll;
    while (nLevel <= nScrollLevel)
    {
        // spawn the spells at this level
        if (nLevel == 0)
        {
                nScrollNum = 10;
        } else if (nLevel == 1)
        {
                nScrollNum = 38;
        } else if (nLevel == 2)
        {
                nScrollNum = 45;
        } else if (nLevel == 3)
        {
                nScrollNum = 47;
        } else if (nLevel == 4)
        {
                nScrollNum = 29;
        } else if (nLevel == 5)
        {
                nScrollNum = 28;
        } else if (nLevel == 6)
        {
                nScrollNum = 27;
        } else if (nLevel == 7)
        {
                nScrollNum = 22;
        } else if (nLevel == 8)
        {
                nScrollNum = 18;
        } else if (nLevel == 9)
        {
                nScrollNum = 19;
        }
        DebugMessage("  Scroll level " + IntToString(nLevel) + " has " + IntToString(nScrollNum) + " scrolls.");

        nScroll = 1;
        while (nScroll <= nScrollNum)
        {
            sScroll = GetScrollResRef(nLevel, nScroll);
            DebugMessage("    Spawning scroll " + sScroll);
            oItem = CreateItemOnObject(sScroll, oStore);
            SetInfiniteFlag(oItem, TRUE);

            nScroll++;
        }

        nLevel++;
    }

    return oStore;
}

//void main(){}

