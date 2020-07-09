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
}

