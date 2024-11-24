/*
 * Author: magicsh0tz
 * Release controls.
 *
 * Arguments:
 * 0: unit that will release controls <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit] call mgc_solo_crew_fnc_releaseControls
 */

#include "script_component.hpp"

params ["_caller"];

private ["_vehicle","_dummyDriver"];

_vehicle = objectParent _caller;
if (isNull _vehicle) exitWith {};

_vehicle setVariable [QVAR(controller),nil,true];

_dummyDriver = _vehicle getVariable [QVAR(dummyDriver),objNull];
if (isNull _dummyDriver) exitWith {};

doStop _dummyDriver;
