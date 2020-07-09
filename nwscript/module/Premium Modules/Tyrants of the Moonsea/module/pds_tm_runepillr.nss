//Open door to Shazgrul's Lair when all pieces of symbol are present

#include "nw_i0_spells"

void main()
{
    int nType=GetInventoryDisturbType();

    if(nType == INVENTORY_DISTURB_TYPE_ADDED)
    {
        if(GetItemPossessedBy(OBJECT_SELF, "SymbolofBaneLowerLeftQuadrant") != OBJECT_INVALID &&
           GetItemPossessedBy(OBJECT_SELF, "SymbolofBaneLowerRightQuadrant") != OBJECT_INVALID &&
           GetItemPossessedBy(OBJECT_SELF, "SymbolofBaneUpperRightQuadrant") != OBJECT_INVALID &&
           GetItemPossessedBy(OBJECT_SELF, "SymbolofBaneUpperLeftQuadrant") != OBJECT_INVALID)
        {
            object oDoor = GetObjectByTag("OldCatacombs_To_ShrazgulsLair");

            RemoveSpecificEffect(EFFECT_TYPE_VISUALEFFECT, oDoor);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_DISPEL_GREATER), oDoor);

            SetLocked(oDoor, FALSE);

            DestroyObject(GetObjectByTag("SymbolofBaneLowerLeftQuadrant"));
            DestroyObject(GetObjectByTag("SymbolofBaneLowerRightQuadrant"));
            DestroyObject(GetObjectByTag("SymbolofBaneUpperRightQuadrant"));
            DestroyObject(GetObjectByTag("SymbolofBaneUpperLeftQuadrant"));

            DelayCommand(1.0, AssignCommand(oDoor, ActionOpenDoor(oDoor)));
        }
    }
}
