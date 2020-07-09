// onEnter event for Leomund's Shelter area
// .. some objects are refreshed whenever the player enters this area

#include "nw_o2_coninclude"

void PurgeOldItems(object oContainer)
{
    object oItem = GetFirstItemInInventory(oContainer);
    while (GetIsObjectValid(oItem))
    {
        if (GetLocalInt(oItem, "nLeomundsItem") == 1)
        {
            if (!GetPlotFlag(oItem))
            {
                DestroyObject(oItem);
            }
        }
        oItem = GetNextItemInInventory(oContainer);
    }
}

void DoCreateNewItem(object oChest, string sTag, int nNum=1)
{
    object oItem = CreateItemOnObject(sTag, oChest, nNum);
    SetLocalInt(oItem, "nLeomundsItem", 1);
}

void CreateNewItem(object oChest, string sTag, int nNum=1)
{
    DelayCommand(3.0, DoCreateNewItem(oChest, sTag, nNum));
}

void CreateNewArcaneScroll(object oChest, object oAdventurer, int nModifier = 0)
{
    int nMaxSpells = 21;
    int nHD = GetHitDice(oAdventurer) + nModifier;
    int nScroll = 1;
    int nLevel = 1;

    if (GetRange(1, nHD))           // l 1-2
    {
      nLevel = d2();
      nScroll =  Random(nMaxSpells) + 1;
    }
    else if (GetRange(2, nHD))      // l 1-4
    {
      nLevel = d4();
      nScroll =  Random(nMaxSpells) + 1;
    }
    else if (GetRange(3, nHD))    // l 2-6
    {
      nLevel = d6();
      if (nLevel < 2) nLevel = 2;

      nScroll =  Random(nMaxSpells) + 1;
    }
    else if (GetRange(4, nHD))   // l 3-8
    {
      nLevel = d8();
      if (nLevel < 3) nLevel = 3;

      nScroll =  Random(nMaxSpells) + 1;
    }
    else if (GetRange(5, nHD))   // l 4-9
    {
      nLevel = d8() + 1;
      if (nLevel < 4) nLevel = 4;

      nScroll =  Random(nMaxSpells) + 1;
    }
    else if (GetRange(6, nHD))   // 5 -9
    {
      nLevel = d8() + 1;
      if (nLevel < 5) nLevel = 5;

      nScroll =  Random(nMaxSpells) + 1;
    }

    nScroll = TrimLevel(nScroll, nLevel);

    string sRes = "nw_it_sparscr216";

    if (nScroll < 10)
    {
        sRes = "NW_IT_SPARSCR" + IntToString(nLevel) + "0" + IntToString(nScroll);
    }
    else
    {
        sRes = "NW_IT_SPARSCR" + IntToString(nLevel) + IntToString(nScroll);
    }
    CreateNewItem(oChest, sRes, 1);
}

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // fill the chest of health with healing kits
        object oChest = GetObjectByTag("ks_ar0090_health");
        if (GetIsObjectValid(oChest))
        {
            PurgeOldItems(oChest);
            CreateNewItem(oChest, "nw_it_medkit001", 1);
            CreateNewItem(oChest, "nw_it_medkit002", 1);
            CreateNewItem(oChest, "nw_it_medkit003", 1);
            CreateNewItem(oChest, "nw_it_medkit004", 1);
        }

        // fill the wizard's bench with craft supplies
        object oBench = GetObjectByTag("ks_ar0090_wizbench");
        if (GetIsObjectValid(oBench))
        {
            PurgeOldItems(oBench);
            CreateNewItem(oBench, "x2_it_cfm_pbottl", 1); // potion bottle
            CreateNewItem(oBench, "x2_it_cfm_pbottl", 1); // potion bottle
            CreateNewItem(oBench, "x2_it_cfm_wand", 1);   // wand bone
            CreateNewItem(oBench, "x2_it_cfm_bscrl", 1);  // blank scroll
            CreateNewItem(oBench, "x2_it_cfm_bscrl", 1);  // blank scroll
            CreateNewItem(oBench, "x2_it_cfm_bscrl", 1);  // blank scroll
        }

        // fill the bookcase with useful scrolls
        object oBooks = GetObjectByTag("ks_ar0090_books");
        if (GetIsObjectValid(oBooks))
        {
            PurgeOldItems(oBooks);
            int n = d6();
            int i;
            for (i=1; i<=n; i++)
            {
                CreateNewArcaneScroll(oBooks, oPC);
            }
        }

        // fill the endless quiver with arrows and bolts
        object oQuiver = GetObjectByTag("ks_ar0090_quiver");
        if (GetIsObjectValid(oQuiver))
        {
            PurgeOldItems(oQuiver);
            CreateNewItem(oQuiver, "nw_wamar001", 50); // arrows
            CreateNewItem(oQuiver, "nw_wambo001", 50); // bolts
        }
    }
}
