/*
 * Author: magicsh0tz
 * Take controls.
 *
 * Arguments:
 * 0: unit that will take controls <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit] call mgc_solo_crew_fnc_takeControls
 */

#include "script_component.hpp"

params ["_caller"];

private ["_vehicle","_dummyDriverClass","_dummyDriver"];

if (!isServer) exitWith {
    // Run on server to prevent race condition.
    _this remoteExecCall [QFUNC(takeControls),2,false];
};

if (!([_caller] call FUNC(canTakeControls))) exitWith {};

_vehicle = objectParent _caller;
if (isNull _vehicle) exitWith {};

_dummyDriverClass = (configfile >> "CfgVehicles" >> (typeOf _vehicle) >> "crew") call BIS_fnc_getCfgData;
if (isNil "_dummyDriverClass") exitWith {};

_dummyDriver = createAgent [_dummyDriverClass,[0,0,0],[],0,"CAN_COLLIDE"];
_dummyDriver allowDamage false;
_dummyDriver hideObjectGlobal true;
_dummyDriver moveInDriver _vehicle;

// Prevent driver from turning out
_dummyDriver setBehaviour "COMBAT";

if (HAS_ACE) then {
    // Remove ace interaction
    [_dummyDriver,_dummyDriver] call ace_common_fnc_claim;
};

_vehicle setVariable [QVAR(controller),_caller,true];
_vehicle setVariable [QVAR(dummyDriver),_dummyDriver,true];

[_caller,_vehicle,_dummyDriver] call FUNC(addHandle);
