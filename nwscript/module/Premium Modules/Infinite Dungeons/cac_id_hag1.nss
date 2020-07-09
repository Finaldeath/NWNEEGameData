#include "inc_id_liltimmy"

void main()
{
    // hagatha was the first lieutenant
    SetLocalInt(GetModule(), "bFirstLieutenant", TRUE);

    // decide on the second lieutenant
    int nLieutenant = Random(2) + 1;

    if (nLieutenant == 1) // baccha
    {
        nLieutenant = 1;
    } else // maggris
    {
        nLieutenant = 3;
    }

    // set the second lieutenant
    lt_SetSecondLieutenant(nLieutenant);
    SetDungeonParameters(1, nLieutenant);
    SetLocalInt(GetModule(), "bPlotDungeon", TRUE);
}
