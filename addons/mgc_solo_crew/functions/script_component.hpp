#include "..\script_component.hpp"

//#define DEBUG_MODE

#define HAS_CBA isClass(configFile >> "CfgPatches" >> "cba_common")
#define HAS_ACE isClass(configFile >> "CfgPatches" >> "ace_common")

#define ALLOWED_TYPES ["Tank","Wheeled_APC_F"]
#define CURRENT_TIME diag_tickTime
#define CONDITION_TIMEOUT 5
