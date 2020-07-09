#include "inc_id1_debug"

// object GetNextCPU()
#include "inc_id1_utility"
#include "inc_id1_prop"


void main()
{
    // property to examine
    int nProperty = GetLocalInt(GetModule(), "nQueueMin");

    // get real property number
    int nPropertyLine = TranslateInternalToExternal(nProperty);

    // get first cost operator
    float fCost = StringToFloat(Get2DAString("itempropdef", "Cost", nPropertyLine));
    string sProperty = Get2DAString("itempropdef", "Label", nPropertyLine);
//    DebugMessage("");
//    DebugMessage("");
//    DebugMessage("Item property " + sProperty + " cost multiplier is " + FloatToString(fCost));

    if (fCost > 0.0)
    {
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTableNum", 1);
        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable1Cost", fCost);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable1Line", -1);
//        DebugMessage("  Set fProperty" + IntToString(nProperty) + "FirstCostTable1Cost to " + FloatToString(fCost));
    } else // there are 5 exceptions
    {
        // bonus feat
        if (nPropertyLine == ITEM_PROPERTY_BONUS_FEAT)
        {
//            DebugMessage("  Bonus feat.");

            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTableNum", 38);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable1Cost", 0.75);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable1Line", 0);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable2Cost", 0.75);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable2Line", 8);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable3Cost", 0.75);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable3Line", 9);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable4Cost", 0.75);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable4Line", 10);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable5Cost", 0.75);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable5Line", 11);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable6Cost", 0.75);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable6Line", 12);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable7Cost", 0.75);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable7Line", 13);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable8Cost", 0.75);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable8Line", 14);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable9Cost", 0.75);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable9Line", 15);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable10Cost", 1.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable10Line", 2);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable11Cost", 1.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable11Line", 4);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable12Cost", 1.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable12Line", 16);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable13Cost", 1.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable13Line", 18);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable14Cost", 1.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable14Line", 20);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable15Cost", 1.05);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable15Line", 28);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable16Cost", 1.2);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable16Line", 19);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable17Cost", 1.25);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable17Line", 5);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable18Cost", 1.5);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable18Line", 1);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable19Cost", 1.5);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable19Line", 3);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable20Cost", 1.5);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable20Line", 6);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable21Cost", 1.5);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable21Line", 7);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable22Cost", 1.5);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable22Line", 17);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable23Cost", 4.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable23Line", 36);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable24Cost", 5.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable24Line", 21);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable25Cost", 5.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable25Line", 22);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable26Cost", 5.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable26Line", 23);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable27Cost", 5.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable27Line", 24);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable28Cost", 5.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable28Line", 25);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable29Cost", 5.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable29Line", 26);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable30Cost", 5.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable30Line", 27);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable31Cost", 5.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable31Line", 29);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable32Cost", 5.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable32Line", 30);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable33Cost", 5.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable33Line", 31);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable34Cost", 5.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable34Line", 32);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable35Cost", 5.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable35Line", 35);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable36Cost", 6.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable36Line", 33);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable37Cost", 7.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable37Line", 34);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable38Cost", 8.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable38Line", 39);
        } else if (nPropertyLine == ITEM_PROPERTY_DAMAGE_REDUCTION) // damage reduction
        {
//            DebugMessage("  Damage Reduction.");

            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTableNum", 20);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable1Cost", 1.25);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable1Line", 0);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable2Cost", 1.75);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable2Line", 1);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable3Cost", 2.25);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable3Line", 2);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable4Cost", 2.5);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable4Line", 3);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable5Cost", 2.75);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable5Line", 4);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable6Cost", 4.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable6Line", 5);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable7Cost", 5.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable7Line", 6);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable8Cost", 6.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable8Line", 7);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable9Cost", 7.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable9Line", 8);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable10Cost", 8.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable10Line", 9);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable11Cost", 10.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable11Line", 10);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable12Cost", 12.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable12Line", 11);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable13Cost", 14.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable13Line", 12);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable14Cost", 16.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable14Line", 13);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable15Cost", 18.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable15Line", 14);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable16Cost", 20.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable16Line", 15);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable17Cost", 22.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable17Line", 16);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable18Cost", 24.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable18Line", 17);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable19Cost", 26.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable19Line", 18);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable20Cost", 28.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable20Line", 19);
        } else if (nPropertyLine == ITEM_PROPERTY_DAMAGE_RESISTANCE) // damage resist
        {
//            DebugMessage("  Damage Resistance.");

            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTableNum", 12);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable1Cost", 0.35);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable1Line", 5);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable2Cost", 0.35);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable2Line", 6);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable3Cost", 0.4);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable3Line", 7);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable4Cost", 0.4);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable4Line", 8);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable5Cost", 0.45);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable5Line", 9);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable6Cost", 0.5);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable6Line", 10);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable7Cost", 0.5);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable7Line", 11);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable8Cost", 0.5);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable8Line", 12);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable9Cost", 0.5);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable9Line", 13);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable10Cost", 1.25);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable10Line", 0);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable11Cost", 1.25);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable11Line", 1);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable12Cost", 1.25);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable12Line", 2);
        } else if (nPropertyLine == ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS) // immunity
        {
//            DebugMessage("  Immunity.");

            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTableNum", 10);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable1Cost", 0.75);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable1Line", 6);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable2Cost", 1.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable2Line", 3);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable3Cost", 1.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable3Line", 4);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable4Cost", 1.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable4Line", 5);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable5Cost", 1.5);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable5Line", 1);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable6Cost", 3.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable6Line", 2);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable7Cost", 3.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable7Line", 7);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable8Cost", 3.5);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable8Line", 9);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable9Cost", 8.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable9Line", 0);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable10Cost", 10.0);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable10Line", 8);
        } else if (nPropertyLine == ITEM_PROPERTY_SAVING_THROW_BONUS) // improved saving throws
        {
//            DebugMessage("  Improved Saving Throws.");

            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTableNum", 14);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable1Cost", 0.4);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable1Line", 1);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable2Cost", 0.4);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable2Line", 3);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable3Cost", 0.4);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable3Line", 6);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable4Cost", 0.4);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable4Line", 7);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable5Cost", 0.4);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable5Line", 8);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable6Cost", 0.4);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable6Line", 14);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable7Cost", 0.4);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable7Line", 15);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable8Cost", 0.5);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable8Line", 5);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable9Cost", 0.5);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable9Line", 9);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable10Cost", 0.5);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable10Line", 13);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable11Cost", 0.75);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable11Line", 4);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable12Cost", 0.75);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable12Line", 11);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable13Cost", 0.75);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable13Line", 12);

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable14Cost", 1.25);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable14Line", 0);
        } else
        {
//            DebugMessage("  Invalid property.");
        }
    }

    // get second cost operator
    int nCost = StringToInt(Get2DAString("itempropdef", "CostTableResRef", nPropertyLine));
//    DebugMessage("Item property " + sProperty + " cost table is " + FloatToString(fCost));

    if (nCost < 1)
    {
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTableNum", 1);
        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable1Cost", 1.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable1Line", -1);
//        DebugMessage("  Set fProperty" + IntToString(nProperty) + "SecondCostTable1Cost to 1.0");
    } else if (nCost == 1)
    {
//        DebugMessage("  Bonus cost table.");

        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTableNum", 12);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable1Cost", 1.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable1Line", 1);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable2Cost", 2.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable2Line", 2);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable3Cost", 3.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable3Line", 3);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable4Cost", 4.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable4Line", 4);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable5Cost", 5.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable5Line", 5);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable6Cost", 6.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable6Line", 6);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable7Cost", 7.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable7Line", 7);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable8Cost", 8.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable8Line", 8);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable9Cost", 9.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable9Line", 9);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable10Cost", 10.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable10Line", 10);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable11Cost", 11.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable11Line", 11);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable12Cost", 12.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable12Line", 12);
    } else if (nCost == 2)
    {
//        DebugMessage("  Melee cost table.");

        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTableNum", 20);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable1Cost", 0.9);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable1Line", 1);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable2Cost", 1.9);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable2Line", 2);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable3Cost", 2.9);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable3Line", 3);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable4Cost", 3.9);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable4Line", 4);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable5Cost", 4.9);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable5Line", 5);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable6Cost", 8.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable6Line", 6);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable7Cost", 11.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable7Line", 7);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable8Cost", 14.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable8Line", 8);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable9Cost", 16.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable9Line", 9);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable10Cost", 26.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable10Line", 10);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable11Cost", 30.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable11Line", 11);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable12Cost", 34.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable12Line", 12);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable13Cost", 38.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable13Line", 13);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable14Cost", 42.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable14Line", 14);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable15Cost", 44.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable15Line", 15);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable16Cost", 46.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable16Line", 16);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable17Cost", 50.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable17Line", 17);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable18Cost", 54.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable18Line", 18);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable19Cost", 58.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable19Line", 19);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable20Cost", 62.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable20Line", 20);
    } else if (nCost == 4)
    {
//        DebugMessage("  Damage cost table.");

        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTableNum", 30);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable1Cost", 0.15);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable1Line", 1);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable2Cost", 0.25);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable2Line", 2);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable3Cost", 0.25);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable3Line", 6);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable4Cost", 0.4);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable4Line", 7);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable5Cost", 0.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable5Line", 3);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable6Cost", 0.65);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable6Line", 8);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable7Cost", 0.75);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable7Line", 4);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable8Cost", 0.75);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable8Line", 9);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable9Cost", 0.75);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable9Line", 12);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable10Cost", 0.85);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable10Line", 10);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable11Cost", 0.95);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable11Line", 11);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable12Cost", 1.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable12Line", 5);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable13Cost", 1.25);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable13Line", 16);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable14Cost", 1.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable14Line", 14);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable15Cost", 1.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable15Line", 17);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable16Cost", 1.75);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable16Line", 13);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable17Cost", 1.75);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable17Line", 18);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable18Cost", 2.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable18Line", 15);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable19Cost", 2.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable19Line", 19);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable20Cost", 2.25);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable20Line", 20);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable21Cost", 2.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable21Line", 21);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable22Cost", 2.75);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable22Line", 22);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable23Cost", 3.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable23Line", 23);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable24Cost", 3.25);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable24Line", 24);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable25Cost", 3.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable25Line", 25);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable26Cost", 3.75);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable26Line", 26);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable27Cost", 4.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable27Line", 27);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable28Cost", 4.25);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable28Line", 28);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable29Cost", 4.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable29Line", 29);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable30Cost", 4.75);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable30Line", 30);
    } else if (nCost == 5)
    {
//        DebugMessage("  Immune cost table.");

        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTableNum", 7);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable1Cost", 0.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable1Line", 1);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable2Cost", 1.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable2Line", 2);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable3Cost", 1.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable3Line", 3);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable4Cost", 2.25);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable4Line", 4);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable5Cost", 3.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable5Line", 5);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable6Cost", 4.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable6Line", 6);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable7Cost", 5.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable7Line", 7);
    } else if (nCost == 6)
    {
//        DebugMessage("  Damage soak cost table.");

        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTableNum", 10);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable1Cost", 2.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable1Line", 1);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable2Cost", 2.4);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable2Line", 2);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable3Cost", 2.8);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable3Line", 3);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable4Cost", 3.2);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable4Line", 4);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable5Cost", 3.6);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable5Line", 5);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable6Cost", 4.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable6Line", 6);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable7Cost", 5.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable7Line", 7);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable8Cost", 6.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable8Line", 8);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable9Cost", 7.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable9Line", 9);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable10Cost", 8.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable10Line", 10);
    } else if (nCost == 7)
    {
//        DebugMessage("  Damage Resist cost table.");

        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTableNum", 10);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable1Cost", 0.75);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable1Line", 1);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable2Cost", 1.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable2Line", 2);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable3Cost", 2.25);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable3Line", 3);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable4Cost", 3.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable4Line", 4);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable5Cost", 5.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable5Line", 5);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable6Cost", 7.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable6Line", 6);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable7Cost", 9.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable7Line", 7);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable8Cost", 12.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable8Line", 8);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable9Cost", 18.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable9Line", 9);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable10Cost", 25.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable10Line", 10);
    } else if (nCost == 10)
    {
//        DebugMessage("  Weight cost table.");

        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTableNum", 5);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable1Cost", 0.1);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable1Line", 1);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable2Cost", 0.2);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable2Line", 2);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable3Cost", 0.3);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable3Line", 3);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable4Cost", 0.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable4Line", 4);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable5Cost", 1.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable5Line", 5);
    } else if (nCost == 11)
    {
//        DebugMessage("  Spell resist cost table.");

        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTableNum", 12);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable1Cost", 0.35);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable1Line", 0);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable2Cost", 0.65);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable2Line", 1);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable3Cost", 1.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable3Line", 2);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable4Cost", 1.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable4Line", 3);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable5Cost", 2.75);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable5Line", 4);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable6Cost", 4.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable6Line", 5);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable7Cost", 5.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable7Line", 6);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable8Cost", 5.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable8Line", 7);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable9Cost", 6.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable9Line", 8);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable10Cost", 7.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable10Line", 9);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable11Cost", 8.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable11Line", 10);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable12Cost", 9.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable12Line", 11);
    } else if (nCost == 13)
    {
//        DebugMessage("  Spell level cost table.");

        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTableNum", 10);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable1Cost", 0.25);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable1Line", 0);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable2Cost", 0.8);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable2Line", 1);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable3Cost", 1.25);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable3Line", 2);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable4Cost", 1.75);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable4Line", 3);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable5Cost", 2.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable5Line", 4);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable6Cost", 3.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable6Line", 5);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable7Cost", 3.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable7Line", 6);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable8Cost", 4.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable8Line", 7);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable9Cost", 4.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable9Line", 8);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable10Cost", 5.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable10Line", 9);
    } else if (nCost == 14)
    {
//        DebugMessage("  Ammo cost table.");

        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTableNum", 9);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable1Cost", 2.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable1Line", 1);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable2Cost", 4.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable2Line", 2);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable3Cost", 4.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable3Line", 3);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable4Cost", 4.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable4Line", 4);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable5Cost", 5.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable5Line", 11);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable6Cost", 6.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable6Line", 12);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable7Cost", 7.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable7Line", 13);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable8Cost", 8.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable8Line", 14);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable9Cost", 9.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable9Line", 15);
    } else if (nCost == 15)
    {
//        DebugMessage("  Weight reduction cost table.");

        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTableNum", 5);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable1Cost", 0.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable1Line", 1);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable2Cost", 0.75);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable2Line", 2);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable3Cost", 1.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable3Line", 3);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable4Cost", 1.25);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable4Line", 4);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable5Cost", 1.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable5Line", 5);
    } else if (nCost == 18)
    {
//        DebugMessage("  Light cost table.");

        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTableNum", 4);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable1Cost", 0.2);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable1Line", 1);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable2Cost", 0.3);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable2Line", 2);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable3Cost", 0.4);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable3Line", 3);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable4Cost", 0.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable4Line", 4);
    } else if (nCost == 23)
    {
//        DebugMessage("  Spell level immunity cost table.");

        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTableNum", 9);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable1Cost", 4.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable1Line", 1);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable2Cost", 5.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable2Line", 2);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable3Cost", 6.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable3Line", 3);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable4Cost", 7.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable4Line", 4);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable5Cost", 8.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable5Line", 5);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable6Cost", 9.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable6Line", 6);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable7Cost", 11.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable7Line", 7);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable8Cost", 13.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable8Line", 8);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable9Cost", 15.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable9Line", 9);
    } else if (nCost == 25)
    {
//        DebugMessage("  Skill cost table.");

        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTableNum", 50);

        int nCount = 1;
        float fValue;
        while (nCount <= 50)
        {
            if (nCount <= 10) // 1
            {
                fValue = nCount * 1.0;
            } else if (nCount <= 35) // 2
            {
                fValue = 10.0 + (nCount - 10) * 2.0;
            } else if (nCount <= 45) // 4
            {
                fValue = 60 + (nCount - 35) * 4.0;
            } else
            {
                fValue = 100.0 + (nCount - 45) * 10.0;
            }

            SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable" + IntToString(nCount) + "Cost", fValue);
            SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable" + IntToString(nCount) + "Line", nCount);

            nCount++;
        }
    } else if (nCost == 27)
    {
//        DebugMessage("  Arcane spell failure cost table.");

        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTableNum", 10);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable1Cost", 1.25);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable1Line", 9);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable2Cost", 1.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable2Line", 8);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable3Cost", 1.75);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable3Line", 7);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable4Cost", 2.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable4Line", 6);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable5Cost", 2.25);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable5Line", 5);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable6Cost", 2.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable6Line", 4);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable7Cost", 2.75);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable7Line", 3);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable8Cost", 3.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable8Line", 2);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable9Cost", 3.5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable9Line", 1);

        SetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable10Cost", 4.0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable10Line", 0);
    }

    // record subtypes
    if (nPropertyLine == ITEM_PROPERTY_ABILITY_BONUS) // 0-5
    {
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubTypeNum", 6);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType1", 0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType2", 1);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType3", 2);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType4", 3);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType5", 4);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType6", 5);
    }
    if ((nPropertyLine == ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP) || (nPropertyLine == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP) || (nPropertyLine == ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP) || (nPropertyLine == ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP)) // 1-5
    {
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubTypeNum", 5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType1", 1);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType2", 2);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType3", 3);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType4", 4);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType5", 5);
    }
    if ((nPropertyLine == ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE) || (nPropertyLine == ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE) || (nPropertyLine == ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE) || (nPropertyLine == ITEM_PROPERTY_UNLIMITED_AMMUNITION)) // 0-2
    {
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubTypeNum", 3);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType1", 0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType2", 1);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType3", 2);
    }
    if ((nPropertyLine == ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP) || (nPropertyLine == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP) || (nPropertyLine == ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP) || (nPropertyLine == ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP)) // 0-20, 23-25, 29
    {
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubTypeNum", 25);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType1", 0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType2", 1);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType3", 2);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType4", 3);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType5", 4);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType6", 5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType7", 6);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType8", 7);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType9", 8);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType10", 9);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType11", 10);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType12", 11);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType13", 12);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType14", 13);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType15", 14);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType16", 15);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType17", 16);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType18", 17);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType19", 18);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType20", 19);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType21", 20);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType22", 23);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType23", 24);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType24", 25);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType25", 29);
    }
    if ((nPropertyLine == ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT) || (nPropertyLine == ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT) || (nPropertyLine == ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT) || (nPropertyLine == ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT)) // 0-8
    {
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubTypeNum", 9);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType1", 0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType2", 1);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType3", 2);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType4", 3);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType5", 4);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType6", 5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType7", 6);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType8", 7);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType9", 8);
    }
    if (nPropertyLine == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N) // 1-3, 6, 7, 9, 10
    {
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubTypeNum", 7);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType1", 1);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType2", 2);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType3", 3);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType4", 6);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType5", 7);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType6", 9);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType7", 10);
    }
    if ((nPropertyLine == ITEM_PROPERTY_DAMAGE_BONUS) || (nPropertyLine == ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE)) // 0-2, 5-13
    {
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubTypeNum", 12);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType1", 0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType2", 1);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType3", 2);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType4", 5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType5", 6);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType6", 7);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType7", 8);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType8", 9);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType9", 10);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType10", 11);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType11", 12);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType12", 13);
    }
    if (nPropertyLine == ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC) // 1-3
    {
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubTypeNum", 3);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType1", 1);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType2", 2);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType3", 3);
    }
    if (nPropertyLine == ITEM_PROPERTY_SKILL_BONUS) // 0-26
    {
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubTypeNum", 27);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType1", 0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType2", 1);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType3", 2);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType4", 3);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType5", 4);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType6", 5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType7", 6);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType8", 7);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType9", 8);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType10", 9);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType11", 10);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType12", 11);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType13", 12);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType14", 13);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType15", 14);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType16", 15);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType17", 16);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType18", 17);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType19", 18);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType20", 19);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType21", 20);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType22", 21);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType23", 22);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType24", 23);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType25", 24);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType26", 25);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType27", 26);
    }
    if (nPropertyLine == ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL) // 0-7
    {
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubTypeNum", 8);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType1", 0);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType2", 1);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType3", 2);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType4", 3);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType5", 4);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType6", 5);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType7", 6);
        SetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SubType8", 7);
    }

    // print back the property values
    int nFirstCostNum = GetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTableNum");
//    DebugMessage("First cost table has " + IntToString(nFirstCostNum) + " properties.");
    int nCount = 1;
    int nLine;
    while (nCount <= nFirstCostNum)
    {
        fCost = GetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "FirstCostTable" + IntToString(nCount) + "Cost");
        nLine = GetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "FirstCostTable" + IntToString(nCount) + "Line");
//        DebugMessage("  Property" + IntToString(nProperty) + "FirstCostTable" + IntToString(nCount) + " is " + FloatToString(fCost) + " on line " + IntToString(nLine));

        nCount++;
    }

//    DebugMessage("");

    int nSecondCostNum = GetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTableNum");
//    DebugMessage("Second cost table has " + IntToString(nSecondCostNum) + " properties.");
    nCount = 1;
    nLine;
    while (nCount <= nSecondCostNum)
    {
        fCost = GetLocalFloat(GetModule(), "fProperty" + IntToString(nProperty) + "SecondCostTable" + IntToString(nCount) + "Cost");
        nLine = GetLocalInt(GetModule(), "nProperty" + IntToString(nProperty) + "SecondCostTable" + IntToString(nCount) + "Line");
//        DebugMessage("  Property" + IntToString(nProperty) + "SecondCostTable" + IntToString(nCount) + " is " + FloatToString(fCost) + " on line " + IntToString(nLine));

        nCount++;
    }

    // if the last property has been reached (49)
    if (nProperty > 48)
    {
//        DebugMessage("    End of item properties. Recording minimum property list.");

        // record property min ranges in order

        SetLocalFloat(GetModule(), "fPropertyMin1Value", 0.035);
        SetLocalInt(GetModule(), "nPropertyMin1Property", 31);

        SetLocalFloat(GetModule(), "fPropertyMin2Value", 0.1);
        SetLocalInt(GetModule(), "nPropertyMin2Property", 12);

        SetLocalFloat(GetModule(), "fPropertyMin3Value", 0.1125);
        SetLocalInt(GetModule(), "nPropertyMin3Property", 17);

        SetLocalFloat(GetModule(), "fPropertyMin4Value", 0.1125);
        SetLocalInt(GetModule(), "nPropertyMin4Property", 18);

        SetLocalFloat(GetModule(), "fPropertyMin5Value", 0.1125);
        SetLocalInt(GetModule(), "nPropertyMin5Property", 40);

        SetLocalFloat(GetModule(), "fPropertyMin6Value", 0.12);
        SetLocalInt(GetModule(), "nPropertyMin6Property", 45);

        SetLocalFloat(GetModule(), "fPropertyMin7Value", 0.125);
        SetLocalInt(GetModule(), "nPropertyMin7Property", 14);

        SetLocalFloat(GetModule(), "fPropertyMin8Value", 0.135);
        SetLocalInt(GetModule(), "nPropertyMin8Property", 10);

        SetLocalFloat(GetModule(), "fPropertyMin9Value", 0.135);
        SetLocalInt(GetModule(), "nPropertyMin9Property", 11);

        SetLocalFloat(GetModule(), "fPropertyMin10Value", 0.2);
        SetLocalInt(GetModule(), "nPropertyMin10Property", 39);

        SetLocalFloat(GetModule(), "fPropertyMin11Value", 0.225);
        SetLocalInt(GetModule(), "nPropertyMin11Property", 16);

        SetLocalFloat(GetModule(), "fPropertyMin12Value", 0.25);
        SetLocalInt(GetModule(), "nPropertyMin12Property", 47);

        SetLocalFloat(GetModule(), "fPropertyMin13Value", 0.2625);
        SetLocalInt(GetModule(), "nPropertyMin13Property", 20);

        SetLocalFloat(GetModule(), "fPropertyMin14Value", 0.27);
        SetLocalInt(GetModule(), "nPropertyMin14Property", 6);

        SetLocalFloat(GetModule(), "fPropertyMin15Value", 0.315);
        SetLocalInt(GetModule(), "nPropertyMin15Property", 25);

        SetLocalFloat(GetModule(), "fPropertyMin16Value", 0.315);
        SetLocalInt(GetModule(), "nPropertyMin16Property", 26);

        SetLocalFloat(GetModule(), "fPropertyMin17Value", 0.36);
        SetLocalInt(GetModule(), "nPropertyMin17Property", 9);

        SetLocalFloat(GetModule(), "fPropertyMin18Value", 0.36);
        SetLocalInt(GetModule(), "nPropertyMin18Property", 43);

        SetLocalFloat(GetModule(), "fPropertyMin19Value", 0.45);
        SetLocalInt(GetModule(), "nPropertyMin19Property", 3);

        SetLocalFloat(GetModule(), "fPropertyMin20Value", 0.45);
        SetLocalInt(GetModule(), "nPropertyMin20Property", 4);

        SetLocalFloat(GetModule(), "fPropertyMin21Value", 0.45);
        SetLocalInt(GetModule(), "nPropertyMin21Property", 5);

        SetLocalFloat(GetModule(), "fPropertyMin22Value", 0.45);
        SetLocalInt(GetModule(), "nPropertyMin22Property", 8);

        SetLocalFloat(GetModule(), "fPropertyMin23Value", 0.45);
        SetLocalInt(GetModule(), "nPropertyMin23Property", 42);

        SetLocalFloat(GetModule(), "fPropertyMin24Value", 0.5);
        SetLocalInt(GetModule(), "nPropertyMin24Property", 22);

        SetLocalFloat(GetModule(), "fPropertyMin25Value", 0.5);
        SetLocalInt(GetModule(), "nPropertyMin25Property", 27);

        SetLocalFloat(GetModule(), "fPropertyMin26Value", 0.5);
        SetLocalInt(GetModule(), "nPropertyMin26Property", 28);

        SetLocalFloat(GetModule(), "fPropertyMin27Value", 0.525);
        SetLocalInt(GetModule(), "nPropertyMin27Property", 15);

        SetLocalFloat(GetModule(), "fPropertyMin28Value", 0.54);
        SetLocalInt(GetModule(), "nPropertyMin28Property", 24);

        SetLocalFloat(GetModule(), "fPropertyMin29Value", 0.585);
        SetLocalInt(GetModule(), "nPropertyMin29Property", 44);

        SetLocalFloat(GetModule(), "fPropertyMin30Value", 0.7);
        SetLocalInt(GetModule(), "nPropertyMin30Property", 46);

        SetLocalFloat(GetModule(), "fPropertyMin31Value", 0.75);
        SetLocalInt(GetModule(), "nPropertyMin31Property", 13);

        SetLocalFloat(GetModule(), "fPropertyMin32Value", 0.75);
        SetLocalInt(GetModule(), "nPropertyMin32Property", 34);

        SetLocalFloat(GetModule(), "fPropertyMin33Value", 0.81);
        SetLocalInt(GetModule(), "nPropertyMin33Property", 2);

        SetLocalFloat(GetModule(), "fPropertyMin34Value", 0.9);
        SetLocalInt(GetModule(), "nPropertyMin34Property", 23);

        SetLocalFloat(GetModule(), "fPropertyMin35Value", 1.0);
        SetLocalInt(GetModule(), "nPropertyMin35Property", 21);

        SetLocalFloat(GetModule(), "fPropertyMin36Value", 1.0);
        SetLocalInt(GetModule(), "nPropertyMin36Property", 38);

        SetLocalFloat(GetModule(), "fPropertyMin37Value", 1.15);
        SetLocalInt(GetModule(), "nPropertyMin37Property", 33);

        SetLocalFloat(GetModule(), "fPropertyMin38Value", 1.2);
        SetLocalInt(GetModule(), "nPropertyMin38Property", 1);

        SetLocalFloat(GetModule(), "fPropertyMin39Value", 1.5);
        SetLocalInt(GetModule(), "nPropertyMin39Property", 32);

        SetLocalFloat(GetModule(), "fPropertyMin40Value", 1.8);
        SetLocalInt(GetModule(), "nPropertyMin40Property", 41);

        SetLocalFloat(GetModule(), "fPropertyMin41Value", 2.0);
        SetLocalInt(GetModule(), "nPropertyMin41Property", 49);

        SetLocalFloat(GetModule(), "fPropertyMin42Value", 2.5);
        SetLocalInt(GetModule(), "nPropertyMin42Property", 7);

        SetLocalFloat(GetModule(), "fPropertyMin43Value", 2.5);
        SetLocalInt(GetModule(), "nPropertyMin43Property", 19);

        SetLocalFloat(GetModule(), "fPropertyMin44Value", 3.0);
        SetLocalInt(GetModule(), "nPropertyMin44Property", 37);

        SetLocalFloat(GetModule(), "fPropertyMin45Value", 3.5);
        SetLocalInt(GetModule(), "nPropertyMin45Property", 30);

        SetLocalFloat(GetModule(), "fPropertyMin46Value", 4.0);
        SetLocalInt(GetModule(), "nPropertyMin46Property", 29);

        SetLocalFloat(GetModule(), "fPropertyMin47Value", 4.8);
        SetLocalInt(GetModule(), "nPropertyMin47Property", 36);

        SetLocalFloat(GetModule(), "fPropertyMin48Value", 6.1);
        SetLocalInt(GetModule(), "nPropertyMin48Property", 35);

        SetLocalFloat(GetModule(), "fPropertyMin49Value", 6.1);
        SetLocalInt(GetModule(), "nPropertyMin49Property", 48);

        // return to the catalog
        DelayCommand(0.01, ExecuteScript("exe_id1_catalog", GetNextCPU()));
    } else // if last property hasnt been reached
    {
//        DebugMessage("    Examining next item property.");

        // set new starting point
        SetLocalInt(GetModule(), "nQueueMin", nProperty + 1);

        // examine entries at new start point
        DelayCommand(0.01, ExecuteScript("exe_id1_cattritp", GetNextCPU()));
    }
}

