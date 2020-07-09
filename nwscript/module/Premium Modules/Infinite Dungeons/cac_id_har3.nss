#include "inc_id_liltimmy"

void main()
{
    // harat was the third inner circle
    SetLocalInt(GetModule(), "bThirdBoss", TRUE);

    // set the halaster as the boss
    SetDungeonParameters(3, 1);
    SetLocalInt(GetModule(), "bPlotDungeon", TRUE);
}
