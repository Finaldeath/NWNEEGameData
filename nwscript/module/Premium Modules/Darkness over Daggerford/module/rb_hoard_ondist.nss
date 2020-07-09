//::///////////////////////////////////////////////
//:: FileName odist_ac_destroy
//:: The placeable destroys itself when the inventory is taken
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/29/2005 11:20:11 PM
//:://////////////////////////////////////////////
void main()
{
    int nType=GetInventoryDisturbType();

     switch (nType)
     {
         case INVENTORY_DISTURB_TYPE_REMOVED:
         case INVENTORY_DISTURB_TYPE_STOLEN:

         SignalEvent(GetObjectByTag("ac_blackdragon"), EventUserDefined(5100));
         break;
    }

    if (!(GetIsObjectValid(GetFirstItemInInventory())))
    {
        SetPlotFlag(OBJECT_SELF,FALSE);
        DestroyObject(OBJECT_SELF);
    }
}
