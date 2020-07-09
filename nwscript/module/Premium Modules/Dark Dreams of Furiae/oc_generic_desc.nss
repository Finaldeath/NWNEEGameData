#include "ddf_util"

void main()
{
    string sDesc = GetLocalString(OBJECT_SELF, "desc");
    debug("-- onclick -- " + sDesc);

    SpeakString(sDesc);
}
