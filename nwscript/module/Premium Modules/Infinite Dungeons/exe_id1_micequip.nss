#include "inc_id1_debug"
// #include "inc_id_onspawn"
#include "x2_inc_itemprop"

void EquipNPCWeapon(int nBonus = 0, object oCreature = OBJECT_SELF);
int GetProficiencyWeapon(int bRanged = TRUE, object oCreature = OBJECT_SELF);
int GetWeaponBaseType(int nWeapon);
void EquipNPCArmor(int nBonus = 0, object oCreature = OBJECT_SELF);
void EquipNPCOffHandWeapon(int nBonus = 0, object oCreature = OBJECT_SELF);
void EquipNPCShield(int nBonus = 0, object oCreature = OBJECT_SELF);

void main()
{
    // get variables
    int nProcess = GetLocalInt(OBJECT_SELF, "nProcess");
    DebugMessage("On process " + IntToString(nProcess));
    int nBonus = GetLocalInt(OBJECT_SELF, "nBonus");
    int bWeapon = GetLocalInt(OBJECT_SELF, "bWeapon");
    int bArmor = GetLocalInt(OBJECT_SELF, "bArmor");
    object oCreature = GetLocalObject(OBJECT_SELF, "oCreature");

    switch (nProcess)
    {
        case 0: // equip weapon
            DebugMessage("");
            DebugMessage("====" + GetTag(oCreature) + " - CREATURE EQUIP MICROPROCESS START====");
            DebugMessage("");

            DebugMessage("Micro-process generating for " + GetTag(oCreature));

            DebugMessage("");
            DebugMessage("====" + GetTag(oCreature) + " - Weapon Equip Start====");
            DebugMessage("");

            // generate a weapon
            if (bWeapon == TRUE)
            {
                DebugMessage("Creature can use a weapon.");

                EquipNPCWeapon(nBonus, oCreature);
            } else
            {
                DebugMessage("Creature cannot use a weapon.");
            }

            DebugMessage("");
            DebugMessage("====" + GetTag(oCreature) + " - Weapon Equip End====");
            DebugMessage("");

            // run next process on MicroCPU
            nProcess++;
            SetLocalInt(OBJECT_SELF, "nProcess", nProcess);
            DelayCommand(0.1, ExecuteScript("exe_id1_micequip", OBJECT_SELF));

            break;

        case 1: // equip armor
            DebugMessage("");
            DebugMessage("====" + GetTag(oCreature) + " - Armor Equip Start====");
            DebugMessage("");

            // generate armor
            if (bArmor == TRUE)
            {
                DebugMessage("Creature can use armor.");

                EquipNPCArmor(nBonus, oCreature);
            } else
            {
                DebugMessage("Creature cannot use armor.");
            }

            DebugMessage("");
            DebugMessage("====" + GetTag(oCreature) + " - Armor Equip End====");
            DebugMessage("");

            // run next process on MicroCPU
            nProcess++;
            SetLocalInt(OBJECT_SELF, "nProcess", nProcess);
            DelayCommand(0.1, ExecuteScript("exe_id1_micequip", OBJECT_SELF));

            break;

        case 2: // equip secondary and destroy self
            // if a second weapon can be used
            if ((GetHasFeat(FEAT_TWO_WEAPON_FIGHTING, oCreature) == TRUE) || (GetHasFeat(FEAT_AMBIDEXTERITY, oCreature) == TRUE))
            {
                DebugMessage("");
                DebugMessage("====" + GetTag(oCreature) + " - Off-Hand Equip Start====");
                DebugMessage("");

                if (bWeapon == TRUE)
                {
                    DebugMessage("Creature can use a weapon.");

                    EquipNPCOffHandWeapon(nBonus, oCreature);
                } else
                {
                    DebugMessage("Creature cannot use a weapon.");
                }

                DebugMessage("");
                DebugMessage("====" + GetTag(oCreature) + " - Off-Hand Equip End====");
                DebugMessage("");
            } else if (GetHasFeat(FEAT_SHIELD_PROFICIENCY, oCreature) == TRUE) // if a shield can be used
            {
                DebugMessage("");
                DebugMessage("====" + GetTag(oCreature) + " - Shield Equip Start====");
                DebugMessage("");

                if (bArmor == TRUE)
                {
                    DebugMessage("Creature can use armor.");

                    EquipNPCShield(nBonus, oCreature);
                } else
                {
                    DebugMessage("Creature cannot use armor.");
                }

                DebugMessage("");
                DebugMessage("====" + GetTag(oCreature) + " - Shield Equip End====");
                DebugMessage("");
            }

            DebugMessage("");
            DebugMessage("====" + GetTag(oCreature) + " - CREATURE EQUIP MICROPROCESS END====");
            DebugMessage("");

            // destroy itself
            DelayCommand(0.01, DestroyObject(OBJECT_SELF));

            break;
    }
}

void EquipNPCWeapon(int nBonus = 0, object oCreature = OBJECT_SELF)
{
    DebugMessage("Equipping NPC weapon. Bonus is " + IntToString(nBonus));

    int nWeapon = -1;
    int nCount;

    // check for improved critical feats
    if (nWeapon == -1)
    {
        nCount = 52;
        while ((nCount <= 89) && (nWeapon == -1))
        {
            if (GetHasFeat(nCount, oCreature) == TRUE)
            {
                nWeapon = nCount - 52;
            } else
            {
                nCount++;
            }
        }
    }
    DebugMessage("Improved critical weapon set to " + IntToString(nWeapon));
    if (nWeapon == -1) // if no normal improved critical feat was found
    {
        if (GetHasFeat(15, oCreature) == TRUE) // special case for club
        {
            nWeapon = 38;
        } else if (GetHasFeat(954, oCreature) == TRUE) // special case for dwarven war axe
        {
            nWeapon = 29;
        } else if (GetHasFeat(995, oCreature) == TRUE)  // special case for whip
        {
            nWeapon = 34;
        }
    }
    DebugMessage("Special improved critical weapon set to " + IntToString(nWeapon));

    // check for weapon specialization feats
    if (nWeapon == -1)
    {
        nCount = 128;
        while ((nCount <= 165) && (nWeapon == -1))
        {
            if (GetHasFeat(nCount, oCreature) == TRUE)
            {
                nWeapon = nCount - 128;
            } else
            {
                nCount++;
            }
        }
    }
    DebugMessage("Weapon specialization weapon set to " + IntToString(nWeapon));
    if (nWeapon == -1) // if no normal weapon specialization feat was found
    {
        if (GetHasFeat(47, oCreature) == TRUE) // special case for club
        {
            nWeapon = 38;
        } else if (GetHasFeat(953, oCreature) == TRUE) // special case for dwarven war axe
        {
            nWeapon = 29;
        } else if (GetHasFeat(994, oCreature) == TRUE)  // special case for whip
        {
            nWeapon = 34;
        }
    }
    DebugMessage("Special weapon specialization weapon set to " + IntToString(nWeapon));

    // check for weapon focus feats
    if (nWeapon == -1)
    {
        nCount = 90;
        while ((nCount <= 127) && (nWeapon == -1))
        {
            if (GetHasFeat(nCount, oCreature) == TRUE)
            {
                nWeapon = nCount - 90;
            } else
            {
                nCount++;
            }
        }
    }
    DebugMessage("Weapon focus weapon set to " + IntToString(nWeapon));
    if (nWeapon == -1) // if no normal weapon focus feat was found
    {
        if (GetHasFeat(43, oCreature) == TRUE) // special case for club
        {
            nWeapon = 38;
        } else if (GetHasFeat(952, oCreature) == TRUE) // special case for dwarven war axe
        {
            nWeapon = 29;
        } else if (GetHasFeat(993, oCreature) == TRUE)  // special case for whip
        {
            nWeapon = 34;
        }
    }
    DebugMessage("Special weapon focus weapon set to " + IntToString(nWeapon));

    // if the NPC has not specialized in a weapon
    if (nWeapon == -1)
    {
        // get any type of weapon
        nWeapon = GetProficiencyWeapon(TRUE, oCreature);
    }
    DebugMessage("Final weapon is " + IntToString(nWeapon));

    // generate the weapon item type from the chosen feat
    if (nWeapon > -1)
    {
        int nWeaponType = GetWeaponBaseType(nWeapon);
        string sResRef = "nw_" + Get2DAString("baseitems", "ItemClass", nWeaponType) +"001";
        DebugMessage("Weapon resref is " + sResRef);

        // Find out if a thrown weapon
        int nStack = StringToInt(Get2DAString("baseitems", "Stacking", nWeaponType));
        if (nStack > 1)
        {
            nStack = d10(9) + 9;
        }
        else
        {
            nStack = 1;
        }

        // create the weapon on the NPC
        object oItem = CreateItemOnObject(sResRef, oCreature,nStack);
        AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_RIGHTHAND));
        SetDroppableFlag(oItem, FALSE);

        // if it is a ranged weapon, but not a thrown one
        if (GetWeaponRanged(oItem) && (nStack == 1))
        {
            DebugMessage("Weapon is ranged. Adding ammunition.");

            // add weapon attack bonus
            if (nBonus > 0)
            {
                IPSafeAddItemProperty(oItem, ItemPropertyAttackBonus(nBonus));
            }

            // determine ammunition
            int nAmmoType = StringToInt(Get2DAString("baseitems", "AmmunitionType", nWeaponType)) - 1;
            sResRef = "nw_" + Get2DAString("ammunitiontypes", "Model", nAmmoType);
            sResRef = GetStringLeft(sResRef, (GetStringLength(sResRef) - 4)) + GetStringRight(sResRef, 3);
            DebugMessage("Ammunition resref is " + sResRef);

            // create the ammunition
            oItem = CreateItemOnObject(sResRef, oCreature, d10(9) + 10);

            // equip the ammunition
            int nDamageType;
            switch(nAmmoType)
            {
                case 0:
                    nAmmoType = INVENTORY_SLOT_ARROWS;
                    nDamageType = IP_CONST_DAMAGETYPE_PIERCING;

                    break;
                case 1:
                    nAmmoType = INVENTORY_SLOT_BOLTS;
                    nDamageType = IP_CONST_DAMAGETYPE_PIERCING;

                    break;
                case 2:
                    nAmmoType = INVENTORY_SLOT_BULLETS;
                    nDamageType = IP_CONST_DAMAGETYPE_BLUDGEONING;

                    break;
            }
            AssignCommand(oCreature, ActionEquipItem(oItem, nAmmoType));
            SetDroppableFlag(oItem, FALSE);

            // add ammunition damage bonus
            if (nBonus > 0)
            {
                IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(nDamageType, nBonus));
            }

            // get a non-ranged weapon
            DebugMessage("  Adding secondary weapon.");
            nWeapon = GetProficiencyWeapon(FALSE, oCreature);
            if (nWeapon > -1)
            {
                nWeaponType = GetWeaponBaseType(nWeapon);
                sResRef = "nw_" + Get2DAString("baseitems", "ItemClass", nWeaponType) +"001";
                DebugMessage("  Secondary weapon resref is " + sResRef);

                // create the weapon on the NPC
                oItem = CreateItemOnObject(sResRef, oCreature, nStack);
                SetDroppableFlag(oItem, FALSE);

                // add weapon enhancement bonus
                if (nBonus > 0)
                {
                    IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
                }
            }
        } else
        {
            // add weapon enhancement bonus
            if (nBonus > 0)
            {
                IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
            }
        }
    }
}

int GetProficiencyWeapon(int bRanged = TRUE, object oCreature = OBJECT_SELF)
{
    int nWeapon = -1;
    int nRoll;

    // if the npc has one of the weapon proficiency feats, use that feat to determine weapons
    if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oCreature) == TRUE) // exotic
    {
        DebugMessage("Has exotic weapon proficiency.");

        if (bRanged == TRUE)
        {
            nRoll = Random(11) + 1;
        } else
        {
            nRoll = Random(10) + 1;
        }
        DebugMessage("  Roll is " + IntToString(nRoll));

        switch (nRoll)
        {
            case 1:     {nWeapon = 33;break;} //BASE_ITEM_BASTARDSWORD
            case 2:     {nWeapon = 37;break;} //BASE_ITEM_TWOBLADEDSWORD
            case 3:     {nWeapon = 35;break;} //BASE_ITEM_DIREMACE
            case 4:     {nWeapon = 36;break;} //BASE_ITEM_DOUBLEAXE
            case 5:     {nWeapon = 27;break;} //BASE_ITEM_KAMA
            case 6:     {nWeapon = 32;break;} //BASE_ITEM_KATANA
            case 7:     {nWeapon = 28;break;} //BASE_ITEM_KUKRI
            case 8:     {nWeapon = 31;break;} //BASE_ITEM_SCYTHE
            case 9:     {nWeapon = 29;break;} //BASE_ITEM_DWARVENWARAXE
            case 10:    {nWeapon = 34;break;} //BASE_ITEM_WHIP
            case 11:    {nWeapon = 30;break;} //BASE_ITEM_SHURIKEN
        }
    } else if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL, oCreature) == TRUE) // martial
    {
        DebugMessage("Has martial weapon proficiency.");

        if (bRanged == TRUE)
        {
            nRoll = Random(16) + 1;
        } else
        {
            nRoll = Random(13) + 1;
        }
        DebugMessage("  Roll is " + IntToString(nRoll));

        switch (nRoll)
        {
            case 1:     {nWeapon = 13;break;}  //BASE_ITEM_SHORTSWORD
            case 2:     {nWeapon = 16;break;}  //BASE_ITEM_LONGSWORD
            case 3:     {nWeapon = 20;break;}  //BASE_ITEM_BATTLEAXE
            case 4:     {nWeapon = 24;break;}  //BASE_ITEM_LIGHTFLAIL
            case 5:     {nWeapon = 25;break;}  //BASE_ITEM_WARHAMMER
            case 6:     {nWeapon = 22;break;}  //BASE_ITEM_HALBERD
            case 7:     {nWeapon = 17;break;}  //BASE_ITEM_GREATSWORD
            case 8:     {nWeapon = 21;break;}  //BASE_ITEM_GREATAXE
            case 9:     {nWeapon = 26;break;}  //BASE_ITEM_HEAVYFLAIL
            case 10:     {nWeapon = 23;break;} //BASE_ITEM_LIGHTHAMMER
            case 11:     {nWeapon = 18;break;} //BASE_ITEM_HANDAXE
            case 12:     {nWeapon = 14;break;} //BASE_ITEM_RAPIER
            case 13:     {nWeapon = 15;break;} //BASE_ITEM_SCIMITAR
            case 14:     {nWeapon = 11;break;} //BASE_ITEM_LONGBOW
            case 15:     {nWeapon = 12;break;} //BASE_ITEM_SHORTBOW
            case 16:     {nWeapon = 19;break;} //BASE_ITEM_THROWINGAXE
        }
    } else if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_ELF, oCreature) == TRUE) // elf
    {
        DebugMessage("Has elf weapon proficiency.");

        if (bRanged == TRUE)
        {
            nRoll = Random(4) + 1;
        } else
        {
            nRoll = Random(2) + 1;
        }
        DebugMessage("  Roll is " + IntToString(nRoll));

        switch (nRoll)
        {
            case 1: {nWeapon = 16;break;}             //BASE_ITEM_LONGSWORD
            case 2: {nWeapon = 14;break;}             //BASE_ITEM_RAPIER
            case 3: {nWeapon = 12;break;}             //BASE_ITEM_SHORTBOW
            case 4: {nWeapon = 11;break;}             //BASE_ITEM_LONGBOW
        }
    } else if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE, oCreature) == TRUE) // simple
    {
        DebugMessage("Has simple weapon proficiency.");

        if (bRanged == TRUE)
        {
            nRoll = Random(11) + 1;
        } else
        {
            nRoll = Random(7) + 1;
        }
        DebugMessage("  Roll is " + IntToString(nRoll));

        switch (nRoll)
        {
            case 1:     {nWeapon = 38;break;} //BASE_ITEM_CLUB
            case 2:     {nWeapon = 0;break;}  //BASE_ITEM_DAGGER
            case 3:     {nWeapon = 4;break;}  //BASE_ITEM_LIGHTMACE
            case 4:     {nWeapon = 5;break;}  //BASE_ITEM_MORNINGSTAR
            case 5:     {nWeapon = 6;break;}  //BASE_ITEM_QUARTERSTAFF
            case 6:     {nWeapon = 7;break;}  //BASE_ITEM_SHORTSPEAR
            case 7:     {nWeapon = 8;break;}  //BASE_ITEM_SICKLE
            case 8:     {nWeapon = 9;break;}  //BASE_ITEM_SLING
            case 9:     {nWeapon = 1;break;}  //BASE_ITEM_DART
            case 10:    {nWeapon = 3;break;}  //BASE_ITEM_LIGHTCROSSBOW
            case 11:    {nWeapon = 2;break;}  //BASE_ITEM_HEAVYCROSSBOW
        }
    } else if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_DRUID, oCreature) == TRUE) // druid
    {
        DebugMessage("Has druid weapon proficiency.");

        if (bRanged == TRUE)
        {
            nRoll = Random(8) + 1;
        } else
        {
            nRoll = Random(6) + 1;
        }
        DebugMessage("  Roll is " + IntToString(nRoll));

        switch (nRoll)
        {
            case 1: {nWeapon = 38;break;}             //BASE_ITEM_CLUB
            case 2: {nWeapon = 0;break;}              //BASE_ITEM_DAGGER
            case 3: {nWeapon = 8;break;}              //BASE_ITEM_SICKLE
            case 4: {nWeapon = 15;break;}             //BASE_ITEM_SCIMITAR
            case 5: {nWeapon = 7;break;}              //BASE_ITEM_SHORTSPEAR
            case 6: {nWeapon = 6;break;}              //BASE_ITEM_QUARTERSTAFF
            case 7: {nWeapon = 1;break;}              //BASE_ITEM_DART
            case 8: {nWeapon = 9;break;}              //BASE_ITEM_SLING
        }
    } else if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_MONK, oCreature) == TRUE) // monk
    {
        DebugMessage("Has monk weapon proficiency.");

        if (bRanged == TRUE)
        {
            nRoll = Random(10) + 1;
        } else
        {
            nRoll = Random(6) + 1;
        }
        DebugMessage("  Roll is " + IntToString(nRoll));

        switch (nRoll)
        {
            case 1:     {nWeapon = 38;break;} //BASE_ITEM_CLUB
            case 2:     {nWeapon = 0;break;}  //BASE_ITEM_DAGGER
            case 3:     {nWeapon = 27;break;} //BASE_ITEM_KAMA
            case 4:     {nWeapon = 6;break;}  //BASE_ITEM_QUARTERSTAFF
            case 5:     {nWeapon = 10;break;} //BASE_ITEM_GLOVES
            case 6:     {nWeapon = 18;break;} //BASE_ITEM_HANDAXE
            case 7:     {nWeapon = 3;break;}  //BASE_ITEM_LIGHTCROSSBOW
            case 8:     {nWeapon = 2;break;}  //BASE_ITEM_HEAVYCROSSBOW
            case 9:     {nWeapon = 9;break;}  //BASE_ITEM_SLING
            case 10:    {nWeapon = 30;break;} //BASE_ITEM_SHURIKEN
        }
    } else if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE, oCreature) == TRUE) // rogue
    {
        DebugMessage("Has rogue weapon proficiency.");

        if (bRanged == TRUE)
        {
            nRoll = Random(11) + 1;
        } else
        {
            nRoll = Random(6) + 1;
        }
        DebugMessage("  Roll is " + IntToString(nRoll));

        switch (nRoll)
        {
            case 1:     {nWeapon = 38;break;} //BASE_ITEM_CLUB
            case 2:     {nWeapon = 0;break;}  //BASE_ITEM_DAGGER
            case 3:     {nWeapon = 4;break;}  //BASE_ITEM_LIGHTMACE
            case 4:     {nWeapon = 5;break;}  //BASE_ITEM_MORNINGSTAR
            case 5:     {nWeapon = 6;break;}  //BASE_ITEM_QUARTERSTAFF
            case 6:     {nWeapon = 14;break;} //BASE_ITEM_RAPIER
            case 7:     {nWeapon = 1;break;}  //BASE_ITEM_DART
            case 8:     {nWeapon = 3;break;}  //BASE_ITEM_LIGHTCROSSBOW
            case 9:     {nWeapon = 2;break;}  //BASE_ITEM_HEAVYCROSSBOW
            case 10:    {nWeapon = 12;break;} //BASE_ITEM_SHORTBOW
            case 11:    {nWeapon = 13;break;} //BASE_ITEM_SHORTSWORD
        }
    } else if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_WIZARD, oCreature) == TRUE) // wizard
    {
        DebugMessage("Has wizard weapon proficiency.");

        if (bRanged == TRUE)
        {
            nRoll = Random(5) + 1;
        } else
        {
            nRoll = Random(3) + 1;
        }
        DebugMessage("  Roll is " + IntToString(nRoll));

        switch (nRoll)
        {
            case 1:     {nWeapon = 38;break;} //BASE_ITEM_CLUB
            case 2:     {nWeapon = 0;break;}  //BASE_ITEM_DAGGER
            case 3:     {nWeapon = 6;break;}  //BASE_ITEM_QUARTERSTAFF
            case 4:     {nWeapon = 3;break;}  //BASE_ITEM_LIGHTCROSSBOW
            case 5:     {nWeapon = 2;break;}  //BASE_ITEM_HEAVYCROSSBOW
        }
    }

    return nWeapon;
}

int GetWeaponBaseType(int nWeapon)
{
    int nWeaponType;
    switch(nWeapon)
    {
        case 0:     {nWeaponType = BASE_ITEM_DAGGER;break;}
        case 1:     {nWeaponType = BASE_ITEM_DART;break;}
        case 2:     {nWeaponType = BASE_ITEM_HEAVYCROSSBOW;break;}
        case 3:     {nWeaponType = BASE_ITEM_LIGHTCROSSBOW;break;}
        case 4:     {nWeaponType = BASE_ITEM_LIGHTMACE;break;}
        case 5:     {nWeaponType = BASE_ITEM_MORNINGSTAR;break;}
        case 6:     {nWeaponType = BASE_ITEM_QUARTERSTAFF;break;}
        case 7:     {nWeaponType = BASE_ITEM_SHORTSPEAR;break;}
        case 8:     {nWeaponType = BASE_ITEM_SICKLE;break;}
        case 9:     {nWeaponType = BASE_ITEM_SLING;break;}
        case 10:    {nWeaponType = BASE_ITEM_GLOVES;break;} // unarmed
        case 11:    {nWeaponType = BASE_ITEM_LONGBOW;break;}
        case 12:    {nWeaponType = BASE_ITEM_SHORTBOW;break;}
        case 13:    {nWeaponType = BASE_ITEM_SHORTSWORD;break;}
        case 14:    {nWeaponType = BASE_ITEM_RAPIER;break;}
        case 15:    {nWeaponType = BASE_ITEM_SCIMITAR;break;}
        case 16:    {nWeaponType = BASE_ITEM_LONGSWORD;break;}
        case 17:    {nWeaponType = BASE_ITEM_GREATSWORD;break;}
        case 18:    {nWeaponType = BASE_ITEM_HANDAXE;break;}
        case 19:    {nWeaponType = BASE_ITEM_THROWINGAXE;break;}
        case 20:    {nWeaponType = BASE_ITEM_BATTLEAXE;break;}
        case 21:    {nWeaponType = BASE_ITEM_GREATAXE;break;}
        case 22:    {nWeaponType = BASE_ITEM_HALBERD;break;}
        case 23:    {nWeaponType = BASE_ITEM_LIGHTHAMMER;break;}
        case 24:    {nWeaponType = BASE_ITEM_LIGHTFLAIL;break;}
        case 25:    {nWeaponType = BASE_ITEM_WARHAMMER;break;}
        case 26:    {nWeaponType = BASE_ITEM_HEAVYFLAIL;break;}
        case 27:    {nWeaponType = BASE_ITEM_KAMA;break;}
        case 28:    {nWeaponType = BASE_ITEM_KUKRI;break;}
        case 29:    {nWeaponType = BASE_ITEM_DWARVENWARAXE;break;}
        case 30:    {nWeaponType = BASE_ITEM_SHURIKEN;break;}
        case 31:    {nWeaponType = BASE_ITEM_SCYTHE;break;}
        case 32:    {nWeaponType = BASE_ITEM_KATANA;break;}
        case 33:    {nWeaponType = BASE_ITEM_BASTARDSWORD;break;}
        case 34:    {nWeaponType = BASE_ITEM_WHIP;break;}
        case 35:    {nWeaponType = BASE_ITEM_DIREMACE;break;}
        case 36:    {nWeaponType = BASE_ITEM_DOUBLEAXE;break;}
        case 37:    {nWeaponType = BASE_ITEM_TWOBLADEDSWORD;break;}
        case 38:    {nWeaponType = BASE_ITEM_CLUB;break;}
    }

    return nWeaponType;
}

void EquipNPCArmor(int nBonus = 0, object oCreature = OBJECT_SELF)
{
    DebugMessage("Equipping NPC armor. Bonus is " + IntToString(nBonus));

    int nLight = 0;
    int nMedium = 0;
    int nHeavy = 0;
    if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_HEAVY, oCreature) == TRUE)
    {
        nHeavy = (nBonus + 1) * 4;
        DebugMessage("  Has heavy armor feat. Value is " + IntToString(nHeavy));
    }
    if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_MEDIUM, oCreature) == TRUE)
    {
        nMedium = (nBonus + 1) * 2;
        DebugMessage("  Has medium armor feat. Value is " + IntToString(nMedium));
    }
    if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_LIGHT, oCreature) == TRUE)
    {
        nLight = (nBonus + 1);
        DebugMessage("  Has light armor feat. Value is " + IntToString(nLight));
    }

    string sResRef = "";

    int nMax = nLight + nMedium + nHeavy;
    DebugMessage("  Armor variable is " + IntToString(nMax));
    if (nMax != 0) // Do only if a valid Armor feat was found.
    {
        int nRoll = Random(nMax) + 1;
        DebugMessage("  Random is " + IntToString(nRoll));
        if (nRoll <= nLight) // light armor
        {
            switch (Random(4) + 1)
            {
                case 1: {sResRef = "nw_aarcl009";break;}
                case 2: {sResRef = "nw_aarcl001";break;}
                case 3: {sResRef = "nw_aarcl002";break;}
                case 4: {sResRef = "nw_aarcl008";break;}
            }
        } else if (nRoll <= (nLight + nMedium)) // medium armor
        {
            switch (Random(4) + 1)
            {
                case 1: {sResRef = "nw_aarcl012";break;}
                case 2: {sResRef = "nw_aarcl003";break;}
                case 3: {sResRef = "nw_aarcl010";break;}
                case 4: {sResRef = "nw_aarcl004";break;}
            }
        } else if (nRoll <= (nLight + nMedium + nHeavy)) // heavy armor
        {
            switch (Random(4) + 1)
            {
                case 1: {sResRef = "nw_aarcl005";break;}
                case 2: {sResRef = "nw_aarcl011";break;}
                case 3: {sResRef = "nw_aarcl006";break;}
                case 4: {sResRef = "nw_aarcl007";break;}
            }
        }
    }
    DebugMessage("  First armor resref is " + sResRef);

    if (sResRef == "")
    {
        DebugMessage("  NPC has no armor.");

        // if the creature has a spellcasting class
        if ((GetLevelByClass(CLASS_TYPE_CLERIC, oCreature) > 0) || (GetLevelByClass(CLASS_TYPE_SORCERER, oCreature) > 0) || (GetLevelByClass(CLASS_TYPE_WIZARD, oCreature) > 0))
        {
            DebugMessage("  Creature has a spellcasting class.");

            switch (Random(8) + 1)
            {
                case 1: {sResRef = "nw_cloth012";break;}
                case 2: {sResRef = "nw_cloth020";break;}
                case 3: {sResRef = "nw_cloth026";break;}
                case 4: {sResRef = "x2_it_pmrobe";break;}
                case 5: {sResRef = "nw_cloth007";break;}
                case 6: {sResRef = "x2_cloth008";break;}
                case 7: {sResRef = "nw_cloth008";break;}
                case 8: {sResRef = "nw_cloth005";break;}
            }
        } else // if the creature does not have a normal spellcasting class
        {
            DebugMessage("  Creature does not have a spellcasting class.");

            switch (Random(18) + 1)
            {
                case 1: {sResRef = "nw_cloth027";break;}
                case 2: {sResRef = "nw_cloth017";break;}
                case 3: {sResRef = "nw_cloth015";break;}
                case 4: {sResRef = "nw_cloth021";break;}
                case 5: {sResRef = "nw_cloth022";break;}
                case 6: {sResRef = "nw_cloth024";break;}
                case 7: {sResRef = "nw_cloth011";break;}
                case 8: {sResRef = "nw_cloth016";break;}
                case 9: {sResRef = "nw_cloth010";break;}
                case 10: {sResRef = "nw_cloth018";break;}
                case 11: {sResRef = "nw_cloth004";break;}
                case 12: {sResRef = "nw_cloth019";break;}
                case 13: {sResRef = "nw_cloth013";break;}
                case 14: {sResRef = "nw_cloth009";break;}
                case 15: {sResRef = "nw_cloth023";break;}
                case 16: {sResRef = "nw_cloth006";break;}
                case 17: {sResRef = "nw_cloth025";break;}
                case 18: {sResRef = "nw_cloth001";break;}
            }
        }
    }
    DebugMessage("  Second armor resref is " + sResRef);

    object oItem = CreateItemOnObject(sResRef, oCreature);
    AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_CHEST));
    SetDroppableFlag(oItem, FALSE);

    if (nBonus > 0)
    {
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
    }
}

void EquipNPCOffHandWeapon(int nBonus = 0, object oCreature = OBJECT_SELF)
{
    DebugMessage("Equipping NPC offhand weapon. Bonus is " + IntToString(nBonus));

    // thrown weapons have odd results
    object oPrimaryWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCreature);
    DebugMessage("  Name of current weapon is " + GetName(oPrimaryWeapon));
    if (GetWeaponRanged(oPrimaryWeapon) == FALSE)
    {
        DebugMessage("  Weapon is not ranged.");

        // Compare the primary weapon size to the size of the creature.
        int nSize = GetCreatureSize(oCreature);
        int nDiff = StringToInt(Get2DAString("baseitems", "WeaponSize", GetBaseItemType(oPrimaryWeapon))) - nSize;
        DebugMessage("  Size " + IntToString(nSize) + " leaves difference of " + IntToString(nDiff));
        if (nDiff <= 0)
        {
            int nWeapon;
            int nWeaponType = -1;
            int nRoll;
            if (nSize <= 2)
            {
                nWeapon = 1;
                if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oCreature) == TRUE)
                {
                    nWeapon = 2;
                }

                nRoll = Random(nWeapon) + 1;
                DebugMessage("  nRoll is " + IntToString(nRoll) + " out of " + IntToString(nWeapon));

                switch (nRoll)
                {
                    case 1:     {nWeaponType = BASE_ITEM_DAGGER;break;}
                    case 2:     {nWeaponType = BASE_ITEM_KUKRI;break;}
                }
            } else if (nSize == 3)
            {
                nWeapon = 4;
                if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oCreature) == TRUE)
                {
                    nWeapon = 6;
                }

                nRoll = Random(nWeapon) + 1;
                DebugMessage("  nRoll is " + IntToString(nRoll) + " out of " + IntToString(nWeapon));

                switch (nRoll)
                {
                    case 1:    {nWeaponType = BASE_ITEM_LIGHTMACE;break;}
                    case 2:    {nWeaponType = BASE_ITEM_SHORTSWORD;break;}
                    case 3:    {nWeaponType = BASE_ITEM_HANDAXE;break;}
                    case 4:    {nWeaponType = BASE_ITEM_LIGHTHAMMER;break;}
                    case 5:    {nWeaponType = BASE_ITEM_KAMA;break;}
                    case 6:    {nWeaponType = BASE_ITEM_WHIP;break;}
                }
            } else if (nSize == 4)
            {
                nWeapon = 9;
                if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oCreature) == TRUE)
                {
                    nWeapon = 11;
                }

                nRoll = Random(nWeapon) + 1;
                DebugMessage("  nRoll is " + IntToString(nRoll) + " out of " + IntToString(nWeapon));

                switch (nRoll)
                {
                    case 1:     {nWeaponType = BASE_ITEM_MORNINGSTAR;break;}
                    case 2:     {nWeaponType = BASE_ITEM_SICKLE;break;}
                    case 3:     {nWeaponType = BASE_ITEM_RAPIER;break;}
                    case 4:     {nWeaponType = BASE_ITEM_SCIMITAR;break;}
                    case 5:     {nWeaponType = BASE_ITEM_LONGSWORD;break;}
                    case 6:     {nWeaponType = BASE_ITEM_BATTLEAXE;break;}
                    case 7:     {nWeaponType = BASE_ITEM_LIGHTFLAIL;break;}
                    case 8:     {nWeaponType = BASE_ITEM_WARHAMMER;break;}
                    case 9:     {nWeaponType = BASE_ITEM_CLUB;break;}
                    case 10:    {nWeaponType = BASE_ITEM_DWARVENWARAXE;break;}
                    case 11:    {nWeaponType = BASE_ITEM_KATANA;break;}
                }
            } else if (nSize >=5)
            {
                nWeapon = 6;
                if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC, oCreature) == TRUE)
                {
                    nWeapon = 8;
                }

                nRoll = Random(nWeapon) + 1;
                DebugMessage("  nRoll is " + IntToString(nRoll) + " out of " + IntToString(nWeapon));

                switch (nRoll)
                {
                    case 1:     {nWeaponType = BASE_ITEM_QUARTERSTAFF;break;}
                    case 2:     {nWeaponType = BASE_ITEM_SHORTSPEAR;break;}
                    case 3:     {nWeaponType = BASE_ITEM_GREATSWORD;break;}
                    case 4:     {nWeaponType = BASE_ITEM_GREATAXE;break;}
                    case 5:     {nWeaponType = BASE_ITEM_HALBERD;break;}
                    case 6:     {nWeaponType = BASE_ITEM_HEAVYFLAIL;break;}
                    case 7:     {nWeaponType = BASE_ITEM_SCYTHE;break;}
                    case 8:     {nWeaponType = BASE_ITEM_BASTARDSWORD;break;}
                }
            }

            // determine resref
            string sResRef = "nw_" + Get2DAString("baseitems", "ItemClass", nWeapon) + "001";
            DebugMessage("  Offhand weapon resref is " + sResRef);

            // create item and equip
            object oItem = CreateItemOnObject(sResRef, oCreature);
            AssignCommand(oCreature, ActionEquipItem(oItem,INVENTORY_SLOT_LEFTHAND));
            SetDroppableFlag(oItem,FALSE);

            // add weapon enhancement bonus
            if (nBonus > 0)
            {
                IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(nBonus));
            }
        }
    }
}

void EquipNPCShield(int nBonus = 0, object oCreature = OBJECT_SELF)
{
    DebugMessage("Equipping NPC shield. Bonus is " + IntToString(nBonus));

    if (GetHasFeat(FEAT_SHIELD_PROFICIENCY))
    {
        // Compare the primary weapon size to the size of the creature
        int nSize = GetCreatureSize(oCreature);
        int nDiff = StringToInt(Get2DAString("baseitems", "WeaponSize", GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)))) - nSize;
        DebugMessage("  Size " + IntToString(nSize) + " leaves difference of " + IntToString(nDiff));
        if (nDiff <= 0)
        {
            int nShield = Random(10) - 2 + nSize;
            DebugMessage("  nShield is " + IntToString(nShield));
            string sResRef;
            if (nShield <= 3)
            {
                sResRef = "nw_ashsw001"; // small
            } else if (nShield >= 10)
            {
                sResRef = "nw_ashto001"; // tower
            } else
            {
                sResRef = "nw_ashlw001"; // large
            }
            DebugMessage("  Shield resref is " + sResRef);

            object oItem = CreateItemOnObject(sResRef, oCreature);
            AssignCommand(oCreature, ActionEquipItem(oItem, INVENTORY_SLOT_LEFTHAND));
            SetDroppableFlag(oItem,FALSE);

            if (nBonus > 0)
            {
                IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nBonus));
            }
        }
    }
}

